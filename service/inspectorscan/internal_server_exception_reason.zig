pub const InternalServerExceptionReason = enum {
    failed_to_generate_sbom,
    other,

    pub const json_field_names = .{
        .failed_to_generate_sbom = "FAILED_TO_GENERATE_SBOM",
        .other = "OTHER",
    };
};
