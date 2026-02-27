pub const PackageGroupAssociationType = enum {
    strong,
    weak,

    pub const json_field_names = .{
        .strong = "STRONG",
        .weak = "WEAK",
    };
};
