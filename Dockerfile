FROM node:18-alpine

WORKDIR /app

# Copy package.json and package-lock.json first for better Docker cache (recommended best practice)
COPY package*.json ./

# Install dependencies (this is a no-op for an empty dependencies block, but needed for real apps)
RUN npm install

# Copy the rest of the app code
COPY . .

# Default command to run your app
CMD ["npm", "start"]
