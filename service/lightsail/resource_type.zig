const std = @import("std");

pub const ResourceType = enum {
    container_service,
    instance,
    static_ip,
    key_pair,
    instance_snapshot,
    domain,
    peered_vpc,
    load_balancer,
    load_balancer_tls_certificate,
    disk,
    disk_snapshot,
    relational_database,
    relational_database_snapshot,
    export_snapshot_record,
    cloud_formation_stack_record,
    alarm,
    contact_method,
    distribution,
    certificate,
    bucket,

    pub const json_field_names = .{
        .container_service = "ContainerService",
        .instance = "Instance",
        .static_ip = "StaticIp",
        .key_pair = "KeyPair",
        .instance_snapshot = "InstanceSnapshot",
        .domain = "Domain",
        .peered_vpc = "PeeredVpc",
        .load_balancer = "LoadBalancer",
        .load_balancer_tls_certificate = "LoadBalancerTlsCertificate",
        .disk = "Disk",
        .disk_snapshot = "DiskSnapshot",
        .relational_database = "RelationalDatabase",
        .relational_database_snapshot = "RelationalDatabaseSnapshot",
        .export_snapshot_record = "ExportSnapshotRecord",
        .cloud_formation_stack_record = "CloudFormationStackRecord",
        .alarm = "Alarm",
        .contact_method = "ContactMethod",
        .distribution = "Distribution",
        .certificate = "Certificate",
        .bucket = "Bucket",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .container_service => "ContainerService",
            .instance => "Instance",
            .static_ip => "StaticIp",
            .key_pair => "KeyPair",
            .instance_snapshot => "InstanceSnapshot",
            .domain => "Domain",
            .peered_vpc => "PeeredVpc",
            .load_balancer => "LoadBalancer",
            .load_balancer_tls_certificate => "LoadBalancerTlsCertificate",
            .disk => "Disk",
            .disk_snapshot => "DiskSnapshot",
            .relational_database => "RelationalDatabase",
            .relational_database_snapshot => "RelationalDatabaseSnapshot",
            .export_snapshot_record => "ExportSnapshotRecord",
            .cloud_formation_stack_record => "CloudFormationStackRecord",
            .alarm => "Alarm",
            .contact_method => "ContactMethod",
            .distribution => "Distribution",
            .certificate => "Certificate",
            .bucket => "Bucket",
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
