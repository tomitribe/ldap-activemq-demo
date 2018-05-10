FROM ${images.owner}/ldap-amq-demo-tomee:${project.version}
COPY ${project.build.finalName}.war /opt/tomee/webapps/ROOT.war
COPY tomee.xml /opt/tomee/conf
COPY --from=${images.owner}/ldap-amq-demo-amq:${project.version} /opt/client.ks /opt/
COPY --from=${images.owner}/ldap-amq-demo-amq:${project.version} /opt/client.ts /opt/