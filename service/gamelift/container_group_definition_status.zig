pub const ContainerGroupDefinitionStatus = enum {
    ready,
    copying,
    failed,

    pub const json_field_names = .{
        .ready = "READY",
        .copying = "COPYING",
        .failed = "FAILED",
    };
};
