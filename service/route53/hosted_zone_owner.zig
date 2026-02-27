/// A complex type that identifies a hosted zone that a specified Amazon VPC is
/// associated
/// with and the owner of the hosted zone. If there is a value for
/// `OwningAccount`, there is no value for `OwningService`, and
/// vice versa.
pub const HostedZoneOwner = struct {
    /// If the hosted zone was created by an Amazon Web Services account, or was
    /// created by an
    /// Amazon Web Services service that creates hosted zones using the current
    /// account,
    /// `OwningAccount` contains the account ID of that account. For example,
    /// when you use Cloud Map to create a hosted zone, Cloud Map creates the hosted
    /// zone using the current Amazon Web Services account.
    owning_account: ?[]const u8,

    /// If an Amazon Web Services service uses its own account to create a hosted
    /// zone and
    /// associate the specified VPC with that hosted zone, `OwningService` contains
    /// an abbreviation that identifies the service. For example, if Amazon Elastic
    /// File System
    /// (Amazon EFS) created a hosted zone and associated a VPC with the hosted
    /// zone, the value
    /// of `OwningService` is `efs.amazonaws.com`.
    owning_service: ?[]const u8,
};
