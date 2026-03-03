const RecordingScope = @import("recording_scope.zig").RecordingScope;

/// A summary of a configuration recorder, including the `arn`, `name`,
/// `servicePrincipal`, and `recordingScope`.
pub const ConfigurationRecorderSummary = struct {
    /// The Amazon Resource Name (ARN) of the configuration recorder.
    arn: []const u8,

    /// The name of the configuration recorder.
    name: []const u8,

    /// Indicates whether the
    /// [ConfigurationItems](https://docs.aws.amazon.com/config/latest/APIReference/API_ConfigurationItem.html) in scope for the configuration recorder are recorded for free (`INTERNAL`) or if you are charged a service fee for recording (`PAID`).
    recording_scope: RecordingScope,

    /// For service-linked configuration recorders, indicates which Amazon Web
    /// Services service the configuration recorder is linked to.
    service_principal: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
        .recording_scope = "recordingScope",
        .service_principal = "servicePrincipal",
    };
};
