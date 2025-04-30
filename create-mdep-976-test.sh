#!/bin/bash

# Set project root
PROJECT_ROOT="mdep-976-test"

# Create directory structure
mkdir -p $PROJECT_ROOT/lib-a/src/main/java/com/example/lib
mkdir -p $PROJECT_ROOT/lib-b/src/main/java/com/other/lib
mkdir -p $PROJECT_ROOT/app/src/main/java/com/example/app

# Create root pom.xml
cat > $PROJECT_ROOT/pom.xml <<EOF
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.example</groupId>
  <artifactId>mdep-976-test</artifactId>
  <version>1.0-SNAPSHOT</version>
  <packaging>pom</packaging>

  <modules>
    <module>lib-a</module>
    <module>lib-b</module>
    <module>app</module>
  </modules>
</project>
EOF

# Create lib-a pom.xml
cat > $PROJECT_ROOT/lib-a/pom.xml <<EOF
<project xmlns="http://maven.apache.org/POM/4.0.0">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.example.lib</groupId>
  <artifactId>shared-lib</artifactId>
  <version>1.0</version>
</project>
EOF

# Create dummy class for lib-a
cat > $PROJECT_ROOT/lib-a/src/main/java/com/example/lib/LibA.java <<EOF
package com.example.lib;

public class LibA {
    public String getMessage() {
        return "Library A";
    }
}
EOF

# Create lib-b pom.xml
cat > $PROJECT_ROOT/lib-b/pom.xml <<EOF
<project xmlns="http://maven.apache.org/POM/4.0.0">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.other.lib</groupId>
  <artifactId>shared-lib</artifactId>
  <version>1.0</version>
</project>
EOF

# Create dummy class for lib-b
cat > $PROJECT_ROOT/lib-b/src/main/java/com/other/lib/LibB.java <<EOF
package com.other.lib;

public class LibB {
    public String getMessage() {
        return "Library B";
    }
}
EOF

# Create app pom.xml
cat > $PROJECT_ROOT/app/pom.xml <<EOF
<project xmlns="http://maven.apache.org/POM/4.0.0">
  <modelVersion>4.0.0</modelVersion>
  <parent>
    <groupId>com.example</groupId>
    <artifactId>mdep-976-test</artifactId>
    <version>1.0-SNAPSHOT</version>
  </parent>
  <artifactId>app</artifactId>

  <dependencies>
    <dependency>
      <groupId>com.example.lib</groupId>
      <artifactId>shared-lib</artifactId>
      <version>1.0</version>
    </dependency>
    <dependency>
      <groupId>com.other.lib</groupId>
      <artifactId>shared-lib</artifactId>
      <version>1.0</version>
    </dependency>
  </dependencies>

  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-dependency-plugin</artifactId>
        <version>3.8.2</version>
        <executions>
          <execution>
            <id>copy-deps</id>
            <phase>process-resources</phase>
            <goals>
              <goal>copy-dependencies</goal>
            </goals>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>
</project>
EOF

# Create dummy class for app
cat > $PROJECT_ROOT/app/src/main/java/com/example/app/App.java <<EOF
package com.example.app;

public class App {
    public static void main(String[] args) {
        System.out.println("Test App");
    }
}
EOF

echo "Project structure created at: $PROJECT_ROOT"
