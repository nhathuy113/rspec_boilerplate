FROM ruby:3.1.6

# Install system dependencies
RUN apt-get update -y \
    && apt-get install -y nodejs npm default-mysql-client \
    && rm -rf /var/lib/apt/lists/*


RUN apt-get update && apt-get install -y curl gnupg unzip \
 && curl -fsSL https://dl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/google-linux.gpg \
 && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-linux.gpg] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
 && apt-get update && apt-get install -y google-chrome-stable \
 && CHROME_MAJOR=$(google-chrome --version | sed -E 's/.* ([0-9]+)\..*/\1/') \
 && CHROMEDRIVER_VERSION=$(curl -sS "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_MAJOR}") \
 && curl -Lo /tmp/chromedriver.zip "https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip" \
 && unzip /tmp/chromedriver.zip -d /usr/local/bin \
 && chmod +x /usr/local/bin/chromedriver \
 && rm -rf /var/lib/apt/lists/* /tmp/*.zip
ENV CHROME_BIN=/usr/bin/google-chrome
ENV WEBDRIVER_CHROME_DRIVER=/usr/local/bin/chromedriver

WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install --jobs=4 --retry=3

# Copy application files
COPY . .

# Make entrypoint script executable
RUN chmod +x docker-entrypoint.sh

# Expose port
EXPOSE 3000

# Set entrypoint
ENTRYPOINT ["./docker-entrypoint.sh"]

# Start Rails server
CMD ["bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0"]
