const EksAccessEntry = @import("eks_access_entry.zig").EksAccessEntry;

/// An object that represents the attributes of an Batch compute environment's
/// Amazon EKS
/// configuration that can be updated. Currently `accessEntry` is the only
/// attribute that you can
/// change after the compute environment is created. For more information, see
/// [Amazon EKS access entry
/// authentication](https://docs.aws.amazon.com/batch/latest/userguide/eks-access-entries.html) in the *Batch User Guide*.
pub const EksConfigurationUpdate = struct {
    /// The updated access entry configuration for the compute environment. Set
    /// `desiredState` to declare whether Batch will manage an access entry on the
    /// cluster.
    /// For the accepted values, see [
    /// `EksAccessEntry`
    /// ](https://docs.aws.amazon.com/batch/latest/APIReference/API_EksAccessEntry.html).
    access_entry: ?EksAccessEntry = null,

    pub const json_field_names = .{
        .access_entry = "accessEntry",
    };
};
