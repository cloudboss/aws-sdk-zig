pub const AllowsUnencryptedObjectUploads = enum {
    @"true",
    @"false",
    unknown,

    pub const json_field_names = .{
        .@"true" = "TRUE",
        .@"false" = "FALSE",
        .unknown = "UNKNOWN",
    };
};
