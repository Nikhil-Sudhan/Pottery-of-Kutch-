# Pottery of Kutch Web Application

This is a Java web application for an e-commerce site selling traditional pottery products from the Kutch region of Gujarat, India.

## Project Structure

The application follows a standard Java web application architecture:

- `src/main/java`: Java source code
  - `com.kutchpottery.model`: Data models (Product, CartItem)
  - `com.kutchpottery.service`: Business logic (ProductService, CartService)
  - `com.kutchpottery.servlet`: Servlets for handling HTTP requests
- `src/main/webapp`: Web resources
  - `WEB-INF`: Configuration files
  - `css`: Stylesheets
  - `js`: JavaScript files
  - `images`: Product and site images
  - JSP files for views

## Prerequisites

- JDK 11 or higher
- Maven 3.6 or higher
- Tomcat 9.0 or similar servlet container

## Building the Application

1. Navigate to the project root directory containing the `pom.xml` file
2. Run the following command to build the application:

```
mvn clean package
```

This will create a WAR file in the `target` directory.

## Running the Application

### Option 1: Deploy to Tomcat

1. Copy the generated WAR file (`target/pottery-web-app.war`) to Tomcat's `webapps` directory
2. Start Tomcat
3. Access the application at `http://localhost:8080/pottery-web-app`

### Option 2: Run with Maven

1. Use the Tomcat Maven plugin to run the application directly:

```
mvn tomcat7:run
```

2. Access the application at `http://localhost:8080/pottery-web-app`

## Features

- Product browsing with category filtering
- Product details view
- Shopping cart functionality
- Responsive design for mobile and desktop

## Images

Before running the application, create example product images in the `src/main/webapp/images` directory. The application is configured to look for images with these names:

- product_1.jpg
- product_2.jpg
- product_3.jpg
- product_4.jpg
- product_5.jpg
- product_6.jpg
- about-image.jpg
- hero-bg.jpg

## Technologies Used

- Java Servlets and JSP
- JSTL for JSP templating
- HTML5, CSS3, and JavaScript
- Maven for build management
- Tomcat as the servlet container
