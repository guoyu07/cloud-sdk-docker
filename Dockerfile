FROM alpine:3.5
ARG CLOUD_SDK_VERSION=159.0.0
ARG SHA256SUM=5b408575407514f99ad913bd0c6991be4b46408ddc7080a6494bbf43e6ce222a
ENV PATH /google-cloud-sdk/bin:$PATH
RUN apk --no-cache add curl python py-crcmod bash libc6-compat && \
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    echo "${SHA256SUM}  google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz" > google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz.sha256 && \
    sha256sum -c google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz.sha256 && \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz.sha256 && \
    ln -s /lib /lib64 && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image
VOLUME ["/root/.config"]
