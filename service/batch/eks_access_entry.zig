const EksAccessEntryDesiredState = @import("eks_access_entry_desired_state.zig").EksAccessEntryDesiredState;
const EksAccessEntryStatus = @import("eks_access_entry_status.zig").EksAccessEntryStatus;

/// Configures whether Batch manages an Amazon EKS access entry on the cluster
/// for the compute
/// environment. For information on how the fields interact with the cluster's
/// `authenticationMode` and with other compute environments that share the
/// cluster,
/// see [Amazon EKS access entry
/// authentication](https://docs.aws.amazon.com/batch/latest/userguide/eks-access-entries.html) in the *Batch User Guide*.
///
/// Setting `desiredState=ENABLED` on a single compute environment does not
/// guarantee that Batch creates an access
/// entry, and setting `desiredState=DISABLED` on a single compute environment
/// does not guarantee that Batch deletes
/// one. Batch compares the `desiredState` across all compute environments that
/// target the same cluster. The Batch-managed access entry is created only when
/// all compute environments have
/// `desiredState=ENABLED`, and deleted only when all have
/// `desiredState=DISABLED`. If you have multiple compute environments on the
/// same
/// cluster, set `desiredState` consistently across all of them to avoid
/// uncertainty.
/// For more information, see [Reconciling
/// desiredState across compute
/// environments](https://docs.aws.amazon.com/batch/latest/userguide/eks-access-entries.html#eks-access-entries-reconciliation) in the
/// *Batch User Guide*.
pub const EksAccessEntry = struct {
    /// The desired access entry state for the compute environment. Valid values:
    ///
    /// **ENABLED**
    ///
    /// Batch manages an access entry on the cluster for the compute environment.
    ///
    /// **DISABLED**
    ///
    /// Batch deletes the Batch-managed access entry for the cluster. This value is
    /// rejected if the cluster's
    /// `authenticationMode` is `API`, because such a cluster doesn't support
    /// the `aws-auth` ConfigMap.
    ///
    /// **INHERIT_FROM_CLUSTER**
    ///
    /// Batch defers to the cluster's current access entry `status`. On a cluster
    /// whose
    /// authentication mode is `API`, Batch creates and manages an access entry. On
    /// a
    /// cluster whose authentication mode is `API_AND_CONFIG_MAP` or
    /// `CONFIG_MAP`, Batch neither adds nor removes an access entry.
    desired_state: EksAccessEntryDesiredState,

    /// The observed state of the access entry on the cluster. `ACTIVE` means that
    /// an
    /// access entry for the compute environment exists on the cluster and takes
    /// precedence over the `aws-auth` ConfigMap. `INACTIVE` means that no
    /// Batch-managed access entry is present. This is a read-only field returned by
    /// `DescribeComputeEnvironments`.
    status: ?EksAccessEntryStatus = null,

    pub const json_field_names = .{
        .desired_state = "desiredState",
        .status = "status",
    };
};
