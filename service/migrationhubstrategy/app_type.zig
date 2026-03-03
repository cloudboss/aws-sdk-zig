const std = @import("std");

pub const AppType = enum {
    dot_net_framework,
    java,
    sql_server,
    iis,
    oracle,
    other,
    tomcat,
    jboss,
    spring,
    mongodb,
    db_2,
    mariadb,
    mysql,
    sybase,
    postgresqlserver,
    cassandra,
    websphere,
    weblogic,
    visualbasic,
    unknown,
    dotnetcore,
    dotnet,

    pub const json_field_names = .{
        .dot_net_framework = "DotNetFramework",
        .java = "Java",
        .sql_server = "SQLServer",
        .iis = "IIS",
        .oracle = "Oracle",
        .other = "Other",
        .tomcat = "Tomcat",
        .jboss = "JBoss",
        .spring = "Spring",
        .mongodb = "Mongo DB",
        .db_2 = "DB2",
        .mariadb = "Maria DB",
        .mysql = "MySQL",
        .sybase = "Sybase",
        .postgresqlserver = "PostgreSQLServer",
        .cassandra = "Cassandra",
        .websphere = "IBM WebSphere",
        .weblogic = "Oracle WebLogic",
        .visualbasic = "Visual Basic",
        .unknown = "Unknown",
        .dotnetcore = "DotnetCore",
        .dotnet = "Dotnet",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dot_net_framework => "DotNetFramework",
            .java => "Java",
            .sql_server => "SQLServer",
            .iis => "IIS",
            .oracle => "Oracle",
            .other => "Other",
            .tomcat => "Tomcat",
            .jboss => "JBoss",
            .spring => "Spring",
            .mongodb => "Mongo DB",
            .db_2 => "DB2",
            .mariadb => "Maria DB",
            .mysql => "MySQL",
            .sybase => "Sybase",
            .postgresqlserver => "PostgreSQLServer",
            .cassandra => "Cassandra",
            .websphere => "IBM WebSphere",
            .weblogic => "Oracle WebLogic",
            .visualbasic => "Visual Basic",
            .unknown => "Unknown",
            .dotnetcore => "DotnetCore",
            .dotnet => "Dotnet",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
