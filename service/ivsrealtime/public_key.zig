const aws = @import("aws");

/// Object specifying a public key used to sign stage participant tokens.
pub const PublicKey = struct {
    /// Public key ARN.
    arn: ?[]const u8 = null,

    /// The public key fingerprint, a short string used to identify or verify the
    /// full public
    /// key.
    fingerprint: ?[]const u8 = null,

    /// Public key name.
    name: ?[]const u8 = null,

    /// Public key material.
    public_key_material: ?[]const u8 = null,

    /// Tags attached to the resource. Array of maps, each of the form
    /// `string:string
    /// (key:value)`. See [Best practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html) in *Tagging AWS Resources and Tag
    /// Editor* for details, including restrictions that apply to tags and "Tag
    /// naming
    /// limits and requirements"; Amazon IVS has no constraints on tags beyond what
    /// is documented
    /// there.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .fingerprint = "fingerprint",
        .name = "name",
        .public_key_material = "publicKeyMaterial",
        .tags = "tags",
    };
};
