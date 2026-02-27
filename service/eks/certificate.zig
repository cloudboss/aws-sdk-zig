/// An object representing the `certificate-authority-data` for your
/// cluster.
pub const Certificate = struct {
    /// The Base64-encoded certificate data required to communicate with your
    /// cluster. Add
    /// this to the `certificate-authority-data` section of the
    /// `kubeconfig` file for your cluster.
    data: ?[]const u8,

    pub const json_field_names = .{
        .data = "data",
    };
};
