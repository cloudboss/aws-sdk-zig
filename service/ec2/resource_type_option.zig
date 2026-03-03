const ImageReferenceOptionName = @import("image_reference_option_name.zig").ImageReferenceOptionName;

/// The options that affect the scope of the response.
pub const ResourceTypeOption = struct {
    /// The name of the option.
    ///
    /// * For `ec2:Instance`:
    ///
    /// Specify `state-name` - The current state of the EC2 instance.
    ///
    /// * For `ec2:LaunchTemplate`:
    ///
    /// Specify `version-depth` - The number of launch template versions to check,
    /// starting from the most recent version.
    option_name: ?ImageReferenceOptionName = null,

    /// A value for the specified option.
    ///
    /// * For `state-name`:
    ///
    /// * Valid values: `pending` | `running` | `shutting-down` |
    /// `terminated` | `stopping` | `stopped`
    ///
    /// * Default: All states
    ///
    /// * For `version-depth`:
    ///
    /// * Valid values: Integers between `1` and `10000`
    ///
    /// * Default: `10`
    option_values: ?[]const []const u8 = null,
};
