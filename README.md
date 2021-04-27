# GKE Jenkins #

This is my `gke jenkins` setup

## helm charts ##

Add the repo `helm repo add stable https://kubernetes-charts.storage.googleapis.com/`

Install the chart`helm install stable/jenkins --generate-name`

```yaml
NAME: jenkins-1578171870
LAST DEPLOYED: Sat Jan  4 13:04:32 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
1. Get your 'admin' user password by running:
  printf $(kubectl get secret --namespace default jenkins-1578171870 -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo
2. Get the Jenkins URL to visit by running these commands in the same shell:
  export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/component=jenkins-master" -l "app.kubernetes.io/instance=jenkins-1594685437" -o jsonpath="{.items[0].metadata.name}")
  echo http://127.0.0.1:8080
  kubectl --namespace default port-forward $POD_NAME 8080:8080

3. Login with the password from step 1 and the username: admin


For more information on running Jenkins on Kubernetes, visit:
https://cloud.google.com/solutions/jenkins-on-container-engine
```

### permissions ###

I ran into some issue with the pods not being able to run `helm` commands, so I had to create the following `clusterrolebinding`

```
kubectl create clusterrolebinding permissive-binding --clusterrole=cluster-admin --user=admin --user=kubelet --group=system:serviceaccounts
```

## Troubleshooting

Here are some issues that I've come across and have had to tackle:

### Github OAuth

I ran into a problem where I was seeing this error after a `Jenkins` restart

```bash
Running from: /usr/share/jenkins/jenkins.war
webroot: EnvVars.masterEnvVars.get("JENKINS_HOME")
2021-04-27 16:22:08.206+0000 [id=1]	INFO	org.eclipse.jetty.util.log.Log#initialized: Logging initialized @638ms to org.eclipse.jetty.util.log.JavaUtilLog
2021-04-27 16:22:08.449+0000 [id=1]	INFO	winstone.Logger#logInternal: Beginning extraction from war file
2021-04-27 16:22:08.494+0000 [id=1]	WARNING	o.e.j.s.handler.ContextHandler#setContextPath: Empty contextPath
2021-04-27 16:22:08.636+0000 [id=1]	INFO	org.eclipse.jetty.server.Server#doStart: jetty-9.4.39.v20210325; built: 2021-03-25T14:42:11.471Z; git: 9fc7ca5a922f2a37b84ec9dbc26a5168cee7e667; jvm 1.8.0_282-b08
2021-04-27 16:22:09.195+0000 [id=1]	INFO	o.e.j.w.StandardDescriptorProcessor#visitServlet: NO JSP Support for /, did not find org.eclipse.jetty.jsp.JettyJspServlet
2021-04-27 16:22:09.302+0000 [id=1]	INFO	o.e.j.s.s.DefaultSessionIdManager#doStart: DefaultSessionIdManager workerName=node0
2021-04-27 16:22:09.303+0000 [id=1]	INFO	o.e.j.s.s.DefaultSessionIdManager#doStart: No SessionScavenger set, using defaults
2021-04-27 16:22:09.304+0000 [id=1]	INFO	o.e.j.server.session.HouseKeeper#startScavenging: node0 Scavenging every 660000ms
2021-04-27 16:22:10.187+0000 [id=1]	INFO	hudson.WebAppMain#contextInitialized: Jenkins home directory: /var/jenkins_home found at: EnvVars.masterEnvVars.get("JENKINS_HOME")
2021-04-27 16:22:10.395+0000 [id=1]	INFO	o.e.j.s.handler.ContextHandler#doStart: Started w.@11d8ae8b{Jenkins v2.277.3,/,file:///var/jenkins_home/war/,AVAILABLE}{/var/jenkins_home/war}
2021-04-27 16:22:10.442+0000 [id=1]	INFO	o.e.j.server.AbstractConnector#doStart: Started ServerConnector@54a097cc{HTTP/1.1, (http/1.1)}{0.0.0.0:8080}
2021-04-27 16:22:10.443+0000 [id=1]	INFO	org.eclipse.jetty.server.Server#doStart: Started @2875ms
2021-04-27 16:22:10.447+0000 [id=21]	INFO	winstone.Logger#logInternal: Winstone Servlet Engine running: controlPort=disabled
2021-04-27 16:22:12.612+0000 [id=27]	INFO	jenkins.InitReactorRunner$1#onAttained: Started initialization
2021-04-27 16:22:12.775+0000 [id=27]	INFO	hudson.ClassicPluginStrategy#createPluginWrapper: Plugin workflow-aggregator.jpi is disabled
2021-04-27 16:22:13.134+0000 [id=27]	INFO	jenkins.InitReactorRunner$1#onAttained: Listed all plugins
2021-04-27 16:22:14.051+0000 [id=26]	SEVERE	jenkins.InitReactorRunner$1#onTaskFailed: Failed Loading plugin Pipeline: Multibranch v2.23 (workflow-multibranch)
java.io.IOException: Failed to load: Pipeline: Multibranch (2.23)
 - Update required: Structs Plugin (1.21) to be updated to 1.22 or higher
	at hudson.PluginWrapper.resolvePluginDependencies(PluginWrapper.java:950)
	at hudson.PluginManager$2$1$1.run(PluginManager.java:550)
	at org.jvnet.hudson.reactor.TaskGraphBuilder$TaskImpl.run(TaskGraphBuilder.java:169)
	at org.jvnet.hudson.reactor.Reactor.runTask(Reactor.java:296)
	at jenkins.model.Jenkins$5.runTask(Jenkins.java:1131)
	at org.jvnet.hudson.reactor.Reactor$2.run(Reactor.java:214)
	at org.jvnet.hudson.reactor.Reactor$Node.run(Reactor.java:117)
	at jenkins.security.ImpersonatingExecutorService$1.run(ImpersonatingExecutorService.java:68)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
	at java.lang.Thread.run(Thread.java:748)
2021-04-27 16:22:14.054+0000 [id=27]	SEVERE	jenkins.InitReactorRunner$1#onTaskFailed: Failed Loading plugin Pipeline: Declarative v1.8.4 (pipeline-model-definition)
java.io.IOException: Failed to load: Pipeline: Declarative (1.8.4)
 - Failed to load: Pipeline: Multibranch (2.23)
	at hudson.PluginWrapper.resolvePluginDependencies(PluginWrapper.java:950)
	at hudson.PluginManager$2$1$1.run(PluginManager.java:550)
	at org.jvnet.hudson.reactor.TaskGraphBuilder$TaskImpl.run(TaskGraphBuilder.java:169)
	at org.jvnet.hudson.reactor.Reactor.runTask(Reactor.java:296)
	at jenkins.model.Jenkins$5.runTask(Jenkins.java:1131)
	at org.jvnet.hudson.reactor.Reactor$2.run(Reactor.java:214)
	at org.jvnet.hudson.reactor.Reactor$Node.run(Reactor.java:117)
	at jenkins.security.ImpersonatingExecutorService$1.run(ImpersonatingExecutorService.java:68)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
	at java.lang.Thread.run(Thread.java:748)
2021-04-27 16:22:14.287+0000 [id=26]	SEVERE	jenkins.InitReactorRunner$1#onTaskFailed: Failed Loading plugin GitHub Authentication plugin v0.33 (github-oauth)
java.io.IOException: Failed to load: GitHub Authentication plugin (0.33)
 - Failed to load: Pipeline: Multibranch (2.23)
	at hudson.PluginWrapper.resolvePluginDependencies(PluginWrapper.java:950)
	at hudson.PluginManager$2$1$1.run(PluginManager.java:550)
	at org.jvnet.hudson.reactor.TaskGraphBuilder$TaskImpl.run(TaskGraphBuilder.java:169)
	at org.jvnet.hudson.reactor.Reactor.runTask(Reactor.java:296)
	at jenkins.model.Jenkins$5.runTask(Jenkins.java:1131)
	at org.jvnet.hudson.reactor.Reactor$2.run(Reactor.java:214)
	at org.jvnet.hudson.reactor.Reactor$Node.run(Reactor.java:117)
	at jenkins.security.ImpersonatingExecutorService$1.run(ImpersonatingExecutorService.java:68)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
	at java.lang.Thread.run(Thread.java:748)
2021-04-27 16:22:24.381+0000 [id=27]	INFO	jenkins.InitReactorRunner$1#onAttained: Prepared all plugins
2021-04-27 16:22:24.468+0000 [id=26]	INFO	jenkins.InitReactorRunner$1#onAttained: Started all plugins
2021-04-27 16:22:27.786+0000 [id=26]	INFO	jenkins.InitReactorRunner$1#onAttained: Augmented all extensions
2021-04-27 16:22:27.829+0000 [id=26]	SEVERE	jenkins.InitReactorRunner$1#onTaskFailed: Failed Loading global config
com.thoughtworks.xstream.mapper.CannotResolveClassException: org.jenkinsci.plugins.GithubSecurityRealm
	at com.thoughtworks.xstream.mapper.DefaultMapper.realClass(DefaultMapper.java:81)
	at com.thoughtworks.xstream.mapper.MapperWrapper.realClass(MapperWrapper.java:125)
	at com.thoughtworks.xstream.mapper.DynamicProxyMapper.realClass(DynamicProxyMapper.java:55)
	at com.thoughtworks.xstream.mapper.MapperWrapper.realClass(MapperWrapper.java:125)
	at com.thoughtworks.xstream.mapper.PackageAliasingMapper.realClass(PackageAliasingMapper.java:88)
	at com.thoughtworks.xstream.mapper.MapperWrapper.realClass(MapperWrapper.java:125)
	at com.thoughtworks.xstream.mapper.ClassAliasingMapper.realClass(ClassAliasingMapper.java:79)
	at com.thoughtworks.xstream.mapper.MapperWrapper.realClass(MapperWrapper.java:125)
	at com.thoughtworks.xstream.mapper.ArrayMapper.realClass(ArrayMapper.java:74)
	at com.thoughtworks.xstream.mapper.MapperWrapper.realClass(MapperWrapper.java:125)
	at com.thoughtworks.xstream.mapper.SecurityMapper.realClass(SecurityMapper.java:71)
	at com.thoughtworks.xstream.mapper.MapperWrapper.realClass(MapperWrapper.java:125)
	at hudson.util.XStream2$CompatibilityMapper.realClass(XStream2.java:378)
	at hudson.util.xstream.MapperDelegate.realClass(MapperDelegate.java:43)
	at com.thoughtworks.xstream.mapper.MapperWrapper.realClass(MapperWrapper.java:125)
	at com.thoughtworks.xstream.mapper.CachingMapper.realClass(CachingMapper.java:47)
	at hudson.util.RobustReflectionConverter.determineType(RobustReflectionConverter.java:507)
	at hudson.util.RobustReflectionConverter.doUnmarshal(RobustReflectionConverter.java:337)
Caused: jenkins.util.xstream.CriticalXStreamException: 
---- Debugging information ----
cause-exception     : com.thoughtworks.xstream.mapper.CannotResolveClassException
cause-message       : org.jenkinsci.plugins.GithubSecurityRealm
class               : hudson.model.Hudson
required-type       : hudson.model.Hudson
converter-type      : hudson.util.RobustReflectionConverter
path                : /hudson/securityRealm
line number         : 50
version             : not available
-------------------------------
	at hudson.util.RobustReflectionConverter.doUnmarshal(RobustReflectionConverter.java:366)
	at hudson.util.RobustReflectionConverter.unmarshal(RobustReflectionConverter.java:280)
	at com.thoughtworks.xstream.core.TreeUnmarshaller.convert(TreeUnmarshaller.java:72)
	at com.thoughtworks.xstream.core.AbstractReferenceUnmarshaller.convert(AbstractReferenceUnmarshaller.java:72)
	at com.thoughtworks.xstream.core.TreeUnmarshaller.convertAnother(TreeUnmarshaller.java:66)
	at com.thoughtworks.xstream.core.TreeUnmarshaller.convertAnother(TreeUnmarshaller.java:50)
	at com.thoughtworks.xstream.core.TreeUnmarshaller.start(TreeUnmarshaller.java:134)
	at com.thoughtworks.xstream.core.AbstractTreeMarshallingStrategy.unmarshal(AbstractTreeMarshallingStrategy.java:32)
	at com.thoughtworks.xstream.XStream.unmarshal(XStream.java:1409)
	at hudson.util.XStream2.unmarshal(XStream2.java:161)
	at hudson.util.XStream2.unmarshal(XStream2.java:132)
	at com.thoughtworks.xstream.XStream.unmarshal(XStream.java:1388)
	at hudson.XmlFile.unmarshal(XmlFile.java:180)
Caused: java.io.IOException: Unable to read /var/jenkins_home/config.xml
	at hudson.XmlFile.unmarshal(XmlFile.java:183)
	at hudson.XmlFile.unmarshal(XmlFile.java:163)
	at jenkins.model.Jenkins.loadConfig(Jenkins.java:3159)
	at jenkins.model.Jenkins.access$1200(Jenkins.java:315)
	at jenkins.model.Jenkins$13.run(Jenkins.java:3260)
	at org.jvnet.hudson.reactor.TaskGraphBuilder$TaskImpl.run(TaskGraphBuilder.java:169)
	at org.jvnet.hudson.reactor.Reactor.runTask(Reactor.java:296)
	at jenkins.model.Jenkins$5.runTask(Jenkins.java:1131)
	at org.jvnet.hudson.reactor.Reactor$2.run(Reactor.java:214)
	at org.jvnet.hudson.reactor.Reactor$Node.run(Reactor.java:117)
	at jenkins.security.ImpersonatingExecutorService$1.run(ImpersonatingExecutorService.java:68)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
	at java.lang.Thread.run(Thread.java:748)
2021-04-27 16:22:27.843+0000 [id=20]	SEVERE	hudson.util.BootFailure#publish: Failed to initialize Jenkins
com.thoughtworks.xstream.mapper.CannotResolveClassException: org.jenkinsci.plugins.GithubSecurityRealm
	at com.thoughtworks.xstream.mapper.DefaultMapper.realClass(DefaultMapper.java:81)
	at com.thoughtworks.xstream.mapper.MapperWrapper.realClass(MapperWrapper.java:125)
	at com.thoughtworks.xstream.mapper.DynamicProxyMapper.realClass(DynamicProxyMapper.java:55)
	at com.thoughtworks.xstream.mapper.MapperWrapper.realClass(MapperWrapper.java:125)
	at com.thoughtworks.xstream.mapper.PackageAliasingMapper.realClass(PackageAliasingMapper.java:88)
	at com.thoughtworks.xstream.mapper.MapperWrapper.realClass(MapperWrapper.java:125)
	at com.thoughtworks.xstream.mapper.ClassAliasingMapper.realClass(ClassAliasingMapper.java:79)
	at com.thoughtworks.xstream.mapper.MapperWrapper.realClass(MapperWrapper.java:125)
	at com.thoughtworks.xstream.mapper.ArrayMapper.realClass(ArrayMapper.java:74)
	at com.thoughtworks.xstream.mapper.MapperWrapper.realClass(MapperWrapper.java:125)
	at com.thoughtworks.xstream.mapper.SecurityMapper.realClass(SecurityMapper.java:71)
	at com.thoughtworks.xstream.mapper.MapperWrapper.realClass(MapperWrapper.java:125)
	at hudson.util.XStream2$CompatibilityMapper.realClass(XStream2.java:378)
	at hudson.util.xstream.MapperDelegate.realClass(MapperDelegate.java:43)
	at com.thoughtworks.xstream.mapper.MapperWrapper.realClass(MapperWrapper.java:125)
	at com.thoughtworks.xstream.mapper.CachingMapper.realClass(CachingMapper.java:47)
	at hudson.util.RobustReflectionConverter.determineType(RobustReflectionConverter.java:507)
	at hudson.util.RobustReflectionConverter.doUnmarshal(RobustReflectionConverter.java:337)
Caused: jenkins.util.xstream.CriticalXStreamException: 
---- Debugging information ----
cause-exception     : com.thoughtworks.xstream.mapper.CannotResolveClassException
cause-message       : org.jenkinsci.plugins.GithubSecurityRealm
class               : hudson.model.Hudson
required-type       : hudson.model.Hudson
converter-type      : hudson.util.RobustReflectionConverter
path                : /hudson/securityRealm
line number         : 50
version             : not available
-------------------------------
	at hudson.util.RobustReflectionConverter.doUnmarshal(RobustReflectionConverter.java:366)
	at hudson.util.RobustReflectionConverter.unmarshal(RobustReflectionConverter.java:280)
	at com.thoughtworks.xstream.core.TreeUnmarshaller.convert(TreeUnmarshaller.java:72)
	at com.thoughtworks.xstream.core.AbstractReferenceUnmarshaller.convert(AbstractReferenceUnmarshaller.java:72)
	at com.thoughtworks.xstream.core.TreeUnmarshaller.convertAnother(TreeUnmarshaller.java:66)
	at com.thoughtworks.xstream.core.TreeUnmarshaller.convertAnother(TreeUnmarshaller.java:50)
	at com.thoughtworks.xstream.core.TreeUnmarshaller.start(TreeUnmarshaller.java:134)
	at com.thoughtworks.xstream.core.AbstractTreeMarshallingStrategy.unmarshal(AbstractTreeMarshallingStrategy.java:32)
	at com.thoughtworks.xstream.XStream.unmarshal(XStream.java:1409)
	at hudson.util.XStream2.unmarshal(XStream2.java:161)
	at hudson.util.XStream2.unmarshal(XStream2.java:132)
	at com.thoughtworks.xstream.XStream.unmarshal(XStream.java:1388)
	at hudson.XmlFile.unmarshal(XmlFile.java:180)
Caused: java.io.IOException: Unable to read /var/jenkins_home/config.xml
	at hudson.XmlFile.unmarshal(XmlFile.java:183)
	at hudson.XmlFile.unmarshal(XmlFile.java:163)
	at jenkins.model.Jenkins.loadConfig(Jenkins.java:3159)
	at jenkins.model.Jenkins.access$1200(Jenkins.java:315)
	at jenkins.model.Jenkins$13.run(Jenkins.java:3260)
	at org.jvnet.hudson.reactor.TaskGraphBuilder$TaskImpl.run(TaskGraphBuilder.java:169)
	at org.jvnet.hudson.reactor.Reactor.runTask(Reactor.java:296)
	at jenkins.model.Jenkins$5.runTask(Jenkins.java:1131)
	at org.jvnet.hudson.reactor.Reactor$2.run(Reactor.java:214)
	at org.jvnet.hudson.reactor.Reactor$Node.run(Reactor.java:117)
	at jenkins.security.ImpersonatingExecutorService$1.run(ImpersonatingExecutorService.java:68)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
	at java.lang.Thread.run(Thread.java:748)
Caused: org.jvnet.hudson.reactor.ReactorException
	at org.jvnet.hudson.reactor.Reactor.execute(Reactor.java:282)
	at jenkins.InitReactorRunner.run(InitReactorRunner.java:49)
	at jenkins.model.Jenkins.executeReactor(Jenkins.java:1164)
	at jenkins.model.Jenkins.<init>(Jenkins.java:962)
	at hudson.model.Hudson.<init>(Hudson.java:85)
	at hudson.model.Hudson.<init>(Hudson.java:81)
	at hudson.WebAppMain$3.run(WebAppMain.java:295)
Caused: hudson.util.HudsonFailedToLoad
	at hudson.WebAppMain$3.run(WebAppMain.java:312)
2021-04-27 16:22:27.963+0000 [id=20]	INFO	jenkins.model.Jenkins#cleanUp: Stopping Jenkins
2021-04-27 16:22:28.601+0000 [id=27]	WARNING	hudson.model.ComputerSet#<clinit>: Failed to instantiate NodeMonitors
java.nio.channels.ClosedByInterruptException
	at java.nio.channels.spi.AbstractInterruptibleChannel.end(AbstractInterruptibleChannel.java:202)
	at sun.nio.ch.FileChannelImpl.read(FileChannelImpl.java:164)
	at sun.nio.ch.ChannelInputStream.read(ChannelInputStream.java:65)
	at sun.nio.ch.ChannelInputStream.read(ChannelInputStream.java:109)
	at sun.nio.ch.ChannelInputStream.read(ChannelInputStream.java:103)
	at java.io.BufferedInputStream.fill(BufferedInputStream.java:246)
	at java.io.BufferedInputStream.read(BufferedInputStream.java:265)
	at java.io.FilterInputStream.read(FilterInputStream.java:83)
	at java.io.PushbackInputStream.read(PushbackInputStream.java:139)
	at com.thoughtworks.xstream.core.util.XmlHeaderAwareReader.getHeader(XmlHeaderAwareReader.java:79)
	at com.thoughtworks.xstream.core.util.XmlHeaderAwareReader.<init>(XmlHeaderAwareReader.java:61)
	at com.thoughtworks.xstream.io.xml.AbstractXppDriver.createReader(AbstractXppDriver.java:65)
Caused: com.thoughtworks.xstream.io.StreamException: 
	at com.thoughtworks.xstream.io.xml.AbstractXppDriver.createReader(AbstractXppDriver.java:69)
	at com.thoughtworks.xstream.XStream.fromXML(XStream.java:1282)
	at hudson.XmlFile.read(XmlFile.java:149)
Caused: java.io.IOException: Unable to read /var/jenkins_home/nodeMonitors.xml
	at hudson.XmlFile.read(XmlFile.java:151)
	at hudson.model.ComputerSet.<clinit>(ComputerSet.java:441)
	at jenkins.metrics.impl.JenkinsHealthCheckProviderImpl.getHealthChecks(JenkinsHealthCheckProviderImpl.java:89)
	at jenkins.metrics.api.HealthCheckProviderListener.onChange(HealthCheckProviderListener.java:93)
	at jenkins.metrics.api.HealthCheckProviderListener.attach(HealthCheckProviderListener.java:79)
	at jenkins.metrics.api.Metrics.afterExtensionsAugmented(Metrics.java:313)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:498)
	at hudson.init.TaskMethodFinder.invoke(TaskMethodFinder.java:104)
	at hudson.init.TaskMethodFinder$TaskImpl.run(TaskMethodFinder.java:175)
	at org.jvnet.hudson.reactor.Reactor.runTask(Reactor.java:296)
	at jenkins.model.Jenkins$5.runTask(Jenkins.java:1131)
	at org.jvnet.hudson.reactor.Reactor$2.run(Reactor.java:214)
	at org.jvnet.hudson.reactor.Reactor$Node.run(Reactor.java:117)
	at jenkins.security.ImpersonatingExecutorService$1.run(ImpersonatingExecutorService.java:68)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1149)
	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:624)
	at java.lang.Thread.run(Thread.java:748)
2021-04-27 16:22:28.626+0000 [id=20]	INFO	jenkins.model.Jenkins$18#onAttained: Started termination
2021-04-27 16:22:28.690+0000 [id=20]	INFO	jenkins.model.Jenkins$18#onAttained: Completed termination
2021-04-27 16:22:28.692+0000 [id=20]	INFO	jenkins.model.Jenkins#_cleanUpDisconnectComputers: Starting node disconnection
2021-04-27 16:22:28.700+0000 [id=20]	INFO	jenkins.model.Jenkins#_cleanUpShutdownPluginManager: Stopping plugin manager
2021-04-27 16:22:28.737+0000 [id=20]	INFO	jenkins.model.Jenkins#_cleanUpPersistQueue: Persisting build queue
2021-04-27 16:22:28.765+0000 [id=20]	INFO	jenkins.model.Jenkins#cleanUp: Jenkins stopped
```

According to this https://serverfault.com/a/888901/595341 the solution is to update `<securityRealm class="org.jenkinsci.plugins.GithubSecurityRealm">` to `<securityRealm class="hudson.security.HudsonPrivateSecurityRealm">`

To do this I need to first extract the file from the failing pod `kubectl cp default/jenkins-1597965510-9f456977-q9f7j:var/jenkins_home/config.xml config.xml`, then modify the config, and then insert the file back into the pod `kubectl cp config.xml default/jenkins-1597965510-9f456977-q9f7j:var/jenkins_home/config.xml`