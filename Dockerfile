FROM rpmbuild:6-build

USER root
RUN yum -y install \
        gettext \
        multilib-rpm-config \
        openssl-devel \
        pam-devel \
        perl-ExtUtils-MakeMaker \
        readline-devel \
        uuid-devel \
        zlib-devel \
    && yum clean all && rm -rf /var/cache/yum

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER
ENTRYPOINT ["/usr/bin/rpmbuild", "postgresql.spec"]
CMD ["-ba"]
