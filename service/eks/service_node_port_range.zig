/// The port range for Kubernetes NodePort services.
pub const ServiceNodePortRange = struct {
    /// The maximum port number in the range.
    max_port: i32 = 0,

    /// The minimum port number in the range.
    min_port: i32 = 0,

    pub const json_field_names = .{
        .max_port = "maxPort",
        .min_port = "minPort",
    };
};
