# Utilizar la imagen oficial de Odoo 16
FROM odoo:16.0 

# Establecer variables de entorno para la localización argentina
ENV ODOO_BASE_URL=https://github.com/ingadhoc
ENV ODOO_REPO_LIST="account-financial-tools account-payment sale odoo-argentina-ce"

# Instalar las dependencias necesarias
USER root
RUN apt-get update && apt-get install -y apt-utils
RUN apt-get install -y git lynx nano vim 

# Clonar los repositorios de Adhoc e instalar los módulos de localización argentina
RUN mkdir -p /mnt/extra-addons \
    && for repo in $ODOO_REPO_LIST; do \
        git clone --depth 1 --branch 16.0 ${ODOO_BASE_URL}/${repo}.git /mnt/extra-addons/${repo}; \
    done

# Establecer el directorio de módulos adicionales
ENV ODOO_ADDONS_PATH=/mnt/extra-addons

# docker build --pull --rm -f "Dockerfile" -t odoo-16.0 "." 


