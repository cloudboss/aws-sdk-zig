pub const DatasourcePackageIngestState = enum {
    started,
    stopped,
    disabled,

    pub const json_field_names = .{
        .started = "STARTED",
        .stopped = "STOPPED",
        .disabled = "DISABLED",
    };
};
