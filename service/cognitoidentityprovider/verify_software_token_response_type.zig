pub const VerifySoftwareTokenResponseType = enum {
    success,
    @"error",

    pub const json_field_names = .{
        .success = "SUCCESS",
        .@"error" = "ERROR",
    };
};
