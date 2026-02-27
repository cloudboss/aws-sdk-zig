pub const Unauthenticated = struct {
    /// Specifies whether you want to turn on or turn off unauthenticated traffic to
    /// your cluster.
    enabled: ?bool,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
