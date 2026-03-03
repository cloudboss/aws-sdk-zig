/// Contains the application runtime IDs and their supported DPU sizes.
pub const ApplicationDPUSizes = struct {
    /// The name of the supported application runtime (for example, `Athena notebook
    /// version 1`).
    application_runtime_id: ?[]const u8 = null,

    /// A list of the supported DPU sizes that the application runtime supports.
    supported_dpu_sizes: ?[]const i32 = null,

    pub const json_field_names = .{
        .application_runtime_id = "ApplicationRuntimeId",
        .supported_dpu_sizes = "SupportedDPUSizes",
    };
};
