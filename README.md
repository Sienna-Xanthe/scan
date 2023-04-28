## **Scan**

The Scan project is an Elixir Phoenix-only API project that serves as the backend for a license plate recognition management system. The project includes the following features:

- User authentication and authorization system using JWT tokens.
- CRUD (Create, Read, Update, Delete) operations for cameras and license plate records.
- Integration with license plate recognition software.

## **Installation**

To install the project, follow these steps:

1. Clone the repository using **`git clone https://github.com/[your-username]/scan.git`**.
2. Install the project dependencies using **`mix deps.get`**.
3. Create the database using **`mix ecto.create`**.
4. Run the database migrations using **`mix ecto.migrate`**.
5. Start the application using **`mix phx.server`**.

You can then access the API at **`http://localhost:4000`**.

## **Deployment**

### **Docker**

To deploy the project using Docker, follow these steps:

1. Build the Docker image using **`docker build -t scan:latest .`** (assuming you are in the project root directory).
2. Run the Docker container using **`docker run -p 4000:4000 scan:latest`**.

You can then access the API at **`http://localhost:4000`**.

### **Local**

To deploy the project locally, follow these steps:

1. Install Elixir and Phoenix.
2. Clone the repository using **`git clone https://github.com/[your-username]/scan.git`**.
3. Install the project dependencies using **`mix deps.get`**.
4. Create the database using **`mix ecto.create`**.
5. Run the database migrations using **`mix ecto.migrate`**.
6. Start the application using **`mix phx.server`**.

You can then access the API at **`http://localhost:4000`**.

### **Render**

To deploy the project on Render, follow these steps:

1. Create a new Render service and select "Docker" as the environment.
2. Use the following values for the Docker configuration:
    
    ```bash
    Build Command: docker build -t scan:latest .
    Start Command: docker run -p 4000:4000 scan:latest
    ```
    
3. Deploy the service.

You can then access the API at the Render service URL.

## **Contributing**

If you would like to contribute to the project, please follow these steps:

1. Fork the repository.
2. Make your changes.
3. Create a pull request.

We welcome all contributions!