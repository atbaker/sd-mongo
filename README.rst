sd-mongo
===========

A MongoDB Dockerfile compatible with the `spin-docker PaaS <https://github.com/atbaker/spin-docker>`_.

Quickstart
----------

This image is available as a trusted build on the docker index. The easiest way to get it on your server is using ``docker pull``:

.. code-block:: bash

    $ docker pull atbaker/sd-mongo

Alternatively, you can clone this repository and build the image yourself:

.. code-block:: bash

    $ docker build -t=sd-mongo .

Using this image
----------------

This image is very insecure! It uses `Phusion's baseimage-docker <https://github.com/phusion/baseimage-docker>`_ and its insecure key for SSH authentication. The MongoDB authentication settings are similarly insecure. **Do not use this image in production without modification.**

Once you have started a container from this image, you can access it via SSH:

.. code-block:: bash
    
    # Use your container's host and port
    $ ssh -i insecure_key root@127.0.0.1 -p 49153
    $ mongo

Or can connect to MongoDB directly if you have the MongoDB client installed:

.. code-block:: bash

    # Use your container's host and port
    $ mongo --host 127.0.0.1 --port 49154

Learn more
----------

Learn more about this image and how to use it in the spin-docker documentation: http://spin-docker.readthedocs.org/

Learn more about Dockerfiles and how to build them in the Docker documentation: http://docs.docker.io/en/latest/reference/builder/
