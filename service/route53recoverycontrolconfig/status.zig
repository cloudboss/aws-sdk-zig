/// The deployment status of a resource. Status can be one of the following:
///
/// PENDING: Amazon Route 53 Application Recovery Controller is creating the
/// resource.
///
/// DEPLOYED: The resource is deployed and ready to use.
///
/// PENDING_DELETION: Amazon Route 53 Application Recovery Controller is
/// deleting the resource.
pub const Status = enum {
    pending,
    deployed,
    pending_deletion,

    pub const json_field_names = .{
        .pending = "PENDING",
        .deployed = "DEPLOYED",
        .pending_deletion = "PENDING_DELETION",
    };
};
