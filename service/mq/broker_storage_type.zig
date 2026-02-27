/// The broker's storage type.
///
/// EFS is not supported for RabbitMQ engine type.
pub const BrokerStorageType = enum {
    ebs,
    efs,

    pub const json_field_names = .{
        .ebs = "EBS",
        .efs = "EFS",
    };
};
