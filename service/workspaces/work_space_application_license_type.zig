pub const WorkSpaceApplicationLicenseType = enum {
    licensed,
    unlicensed,

    pub const json_field_names = .{
        .licensed = "LICENSED",
        .unlicensed = "UNLICENSED",
    };
};
