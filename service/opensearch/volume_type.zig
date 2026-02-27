/// The type of EBS volume that a domain uses. For more information, see
/// [Configuring EBS-based
/// storage](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/opensearch-createupdatedomains.html#opensearch-createdomain-configure-ebs).
pub const VolumeType = enum {
    standard,
    gp_2,
    io_1,
    gp_3,

    pub const json_field_names = .{
        .standard = "standard",
        .gp_2 = "gp2",
        .io_1 = "io1",
        .gp_3 = "gp3",
    };
};
