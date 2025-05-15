# Use Python 3.7 as a base image
FROM python:3.7
# Copy contents into image
COPY . .
# Install pip dependencies from requirements
RUN pip install -r requirements.txt
RUN chmod +x app.py
# Expose correct port
EXPOSE 5000
ENV MYSQL_ROOT_PASSWORD=password
# Create an entrypoint
CMD [ "python", "./app.py" ]

