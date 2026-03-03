const std = @import("std");

pub const AssetBundleExportJobDataSourcePropertyToOverride = enum {
    name,
    disable_ssl,
    secret_arn,
    username,
    password,
    domain,
    work_group,
    host,
    port,
    database,
    data_set_name,
    catalog,
    instance_id,
    cluster_id,
    manifest_file_location,
    warehouse,
    role_arn,
    product_type,

    pub const json_field_names = .{
        .name = "Name",
        .disable_ssl = "DisableSsl",
        .secret_arn = "SecretArn",
        .username = "Username",
        .password = "Password",
        .domain = "Domain",
        .work_group = "WorkGroup",
        .host = "Host",
        .port = "Port",
        .database = "Database",
        .data_set_name = "DataSetName",
        .catalog = "Catalog",
        .instance_id = "InstanceId",
        .cluster_id = "ClusterId",
        .manifest_file_location = "ManifestFileLocation",
        .warehouse = "Warehouse",
        .role_arn = "RoleArn",
        .product_type = "ProductType",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .name => "Name",
            .disable_ssl => "DisableSsl",
            .secret_arn => "SecretArn",
            .username => "Username",
            .password => "Password",
            .domain => "Domain",
            .work_group => "WorkGroup",
            .host => "Host",
            .port => "Port",
            .database => "Database",
            .data_set_name => "DataSetName",
            .catalog => "Catalog",
            .instance_id => "InstanceId",
            .cluster_id => "ClusterId",
            .manifest_file_location => "ManifestFileLocation",
            .warehouse => "Warehouse",
            .role_arn => "RoleArn",
            .product_type => "ProductType",
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
