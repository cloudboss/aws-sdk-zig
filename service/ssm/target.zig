/// An array of search criteria that targets managed nodes using a key-value
/// pair that you
/// specify.
///
/// One or more targets must be specified for maintenance window Run
/// Command-type tasks.
/// Depending on the task, targets are optional for other maintenance window
/// task types (Automation,
/// Lambda, and Step Functions). For more information about running tasks
/// that don't specify targets, see [Registering
/// maintenance window tasks without
/// targets](https://docs.aws.amazon.com/systems-manager/latest/userguide/maintenance-windows-targetless-tasks.html) in the
/// *Amazon Web Services Systems Manager User Guide*.
///
/// Supported formats include the following.
///
/// **For all Systems Manager tools:**
///
/// * `Key=tag-key,Values=tag-value-1,tag-value-2`
///
/// **For Automation and Change Manager:**
///
/// * `Key=tag:tag-key,Values=tag-value`
///
/// * `Key=ResourceGroup,Values=resource-group-name`
///
/// * `Key=ParameterValues,Values=value-1,value-2,value-3`
///
/// * To target all instances in the Amazon Web Services Region:
///
/// * `Key=AWS::EC2::Instance,Values=*`
///
/// * `Key=InstanceIds,Values=*`
///
/// **For Run Command and Maintenance Windows:**
///
/// * `Key=InstanceIds,Values=instance-id-1,instance-id-2,instance-id-3`
///
/// * `Key=tag:tag-key,Values=tag-value-1,tag-value-2`
///
/// * `Key=resource-groups:Name,Values=resource-group-name`
///
/// * Additionally, Maintenance Windows support targeting resource types:
///
/// *
///   `Key=resource-groups:ResourceTypeFilters,Values=resource-type-1,resource-type-2`
///
/// **For State Manager:**
///
/// * `Key=InstanceIds,Values=instance-id-1,instance-id-2,instance-id-3`
///
/// * `Key=tag:tag-key,Values=tag-value-1,tag-value-2`
///
/// * To target all instances in the Amazon Web Services Region:
///
/// * `Key=InstanceIds,Values=*`
///
/// For more information about how to send commands that target managed nodes
/// using
/// `Key,Value` parameters, see [Targeting multiple managed
/// nodes](https://docs.aws.amazon.com/systems-manager/latest/userguide/send-commands-multiple.html#send-commands-targeting) in the *Amazon Web Services Systems Manager User Guide*.
pub const Target = struct {
    /// User-defined criteria for sending commands that target managed nodes that
    /// meet the
    /// criteria.
    key: ?[]const u8,

    /// User-defined criteria that maps to `Key`. For example, if you specified
    /// `tag:ServerRole`, you could specify `value:WebServer` to run a command on
    /// instances that include EC2 tags of `ServerRole,WebServer`.
    ///
    /// Depending on the type of target, the maximum number of values for a key
    /// might be lower than
    /// the global maximum of 50.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .values = "Values",
    };
};
