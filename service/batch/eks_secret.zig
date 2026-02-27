/// Specifies the configuration of a Kubernetes `secret` volume. For more
/// information, see
/// [secret](https://kubernetes.io/docs/concepts/storage/volumes/#secret) in the
/// *Kubernetes documentation*.
pub const EksSecret = struct {
    /// Specifies whether the secret or the secret's keys must be defined.
    optional: ?bool,

    /// The name of the secret. The name must be allowed as a DNS subdomain name.
    /// For more
    /// information, see [DNS subdomain
    /// names](https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#dns-subdomain-names) in the *Kubernetes documentation*.
    secret_name: []const u8,

    pub const json_field_names = .{
        .optional = "optional",
        .secret_name = "secretName",
    };
};
