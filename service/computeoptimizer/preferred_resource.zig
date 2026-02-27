const PreferredResourceName = @import("preferred_resource_name.zig").PreferredResourceName;

/// The preference to control which resource type values are considered when
/// generating rightsizing recommendations.
/// You can specify this preference as a combination of include and exclude
/// lists. You must specify either an
/// `includeList` or `excludeList`. If the preference is an empty set of
/// resource type values,
/// an error occurs. For more information, see [
/// Rightsizing recommendation
/// preferences](https://docs.aws.amazon.com/compute-optimizer/latest/ug/rightsizing-preferences.html) in the *Compute Optimizer User
/// Guide*.
///
/// * This preference is only available for the Amazon EC2 instance and Amazon
///   EC2 Auto Scaling group resource types.
///
/// * Compute Optimizer only supports the customization of `Ec2InstanceTypes`.
pub const PreferredResource = struct {
    /// The preferred resource type values to exclude from the recommendation
    /// candidates. If this isn’t specified, all supported
    /// resources are included by default. You can specify up to 1000 values in this
    /// list.
    exclude_list: ?[]const []const u8,

    /// The preferred resource type values to include in the recommendation
    /// candidates. You can specify the exact resource type value,
    /// such as m5.large, or use wild card expressions, such as m5. If this isn’t
    /// specified, all supported resources are included by default.
    /// You can specify up to 1000 values in this list.
    include_list: ?[]const []const u8,

    /// The type of preferred resource to customize.
    ///
    /// Compute Optimizer only supports the customization of `Ec2InstanceTypes`.
    name: ?PreferredResourceName,

    pub const json_field_names = .{
        .exclude_list = "excludeList",
        .include_list = "includeList",
        .name = "name",
    };
};
