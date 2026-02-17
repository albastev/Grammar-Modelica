FROM rakudo-star:latest

WORKDIR /app

# Install distribution dependencies first so Docker can cache this layer.
COPY META6.json /app/META6.json
RUN zef --deps-only install .

# Copy project files and run the test suite by default.
COPY . /app
CMD ["prove", "-e", "raku -Ilib", "-r", "t"]