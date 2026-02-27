/// The image type is the type of AppStream image resource.
pub const AgentSoftwareVersion = enum {
    current_latest,
    always_latest,

    pub const json_field_names = .{
        .current_latest = "CURRENT_LATEST",
        .always_latest = "ALWAYS_LATEST",
    };
};
