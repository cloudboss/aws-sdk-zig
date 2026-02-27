/// The type of EBS volume, standard, gp2, gp3 or io1. See [Configuring
/// EBS-based
/// Storage](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-createupdatedomains.html#es-createdomain-configure-ebs)for more information.
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
