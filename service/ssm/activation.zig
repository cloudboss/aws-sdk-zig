const Tag = @import("tag.zig").Tag;

/// An activation registers one or more on-premises servers or virtual machines
/// (VMs) with Amazon Web Services
/// so that you can configure those servers or VMs using Run Command. A server
/// or VM that has been
/// registered with Amazon Web Services Systems Manager is called a managed
/// node.
pub const Activation = struct {
    /// The ID created by Systems Manager when you submitted the activation.
    activation_id: ?[]const u8,

    /// The date the activation was created.
    created_date: ?i64,

    /// A name for the managed node when it is created.
    default_instance_name: ?[]const u8,

    /// A user defined description of the activation.
    description: ?[]const u8,

    /// The date when this activation can no longer be used to register managed
    /// nodes.
    expiration_date: ?i64,

    /// Whether or not the activation is expired.
    expired: bool = false,

    /// The Identity and Access Management (IAM) role to assign to the managed node.
    iam_role: ?[]const u8,

    /// The maximum number of managed nodes that can be registered using this
    /// activation.
    registration_limit: ?i32,

    /// The number of managed nodes already registered with this activation.
    registrations_count: ?i32,

    /// Tags assigned to the activation.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .activation_id = "ActivationId",
        .created_date = "CreatedDate",
        .default_instance_name = "DefaultInstanceName",
        .description = "Description",
        .expiration_date = "ExpirationDate",
        .expired = "Expired",
        .iam_role = "IamRole",
        .registration_limit = "RegistrationLimit",
        .registrations_count = "RegistrationsCount",
        .tags = "Tags",
    };
};
