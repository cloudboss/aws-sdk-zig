pub const LambdaEventStructureVersion = enum {
    /// This is the default lambda event structure version
    v1,
    /// Indicates use of lambda event structure version 2
    v2,

    pub const json_field_names = .{
        .v1 = "V1",
        .v2 = "V2",
    };
};
