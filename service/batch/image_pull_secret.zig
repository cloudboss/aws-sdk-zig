/// References a Kubernetes secret resource. This name of the secret must start
/// and end with an
/// alphanumeric character, is required to be lowercase, can include periods (.)
/// and hyphens (-), and
/// can't contain more than 253 characters.
pub const ImagePullSecret = struct {
    /// Provides a unique identifier for the `ImagePullSecret`. This object is
    /// required
    /// when `EksPodProperties$imagePullSecrets` is used.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
