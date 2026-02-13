/// The filters to describe or get information about your managed nodes.
pub const InstanceInformationStringFilter = struct {
    /// The filter key name to describe your managed nodes.
    ///
    /// Valid filter key values: ActivationIds | AgentVersion | AssociationStatus |
    /// IamRole |
    /// InstanceIds | PingStatus | PlatformType | ResourceType | SourceIds |
    /// SourceTypes | "tag-key" |
    /// "tag:`{keyname}`
    ///
    /// * Valid values for the `AssociationStatus` filter key: Success | Pending |
    /// Failed
    ///
    /// * Valid values for the `PingStatus` filter key: Online | ConnectionLost |
    /// Inactive (deprecated)
    ///
    /// * Valid values for the `PlatformType` filter key: Windows | Linux | MacOS
    ///
    /// * Valid values for the `ResourceType` filter key: EC2Instance |
    /// ManagedInstance
    ///
    /// * Valid values for the `SourceType` filter key: AWS::EC2::Instance |
    /// AWS::SSM::ManagedInstance | AWS::IoT::Thing
    ///
    /// * Valid tag examples: `Key=tag-key,Values=Purpose` |
    /// `Key=tag:Purpose,Values=Test`.
    key: []const u8,

    /// The filter values.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .values = "Values",
    };
};
