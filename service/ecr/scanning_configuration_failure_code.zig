pub const ScanningConfigurationFailureCode = enum {
    repository_not_found,

    pub const json_field_names = .{
        .repository_not_found = "REPOSITORY_NOT_FOUND",
    };
};
