/// The version of the VPC link.
pub const VpcLinkVersion = enum {
    v2,

    pub const json_field_names = .{
        .v2 = "V2",
    };
};
