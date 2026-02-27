/// Matching rule statement.
pub const MatchingRuleStatement = struct {
    /// Constraint.
    constraint: []const u8,

    /// Key to match.
    ///
    /// The following keys and are supported when the RuleStatement type
    /// is `Instance`:
    ///
    /// * `Platform` - The name of the platform.
    /// Logical operators are `EQUALS` and `NOT_EQUALS`.
    ///
    /// * `EC2BillingProduct` - The billing product code.
    /// Logical operators are `EQUALS` and `NOT_EQUALS`.
    /// Possible values are: `windows-server-enterprise` |
    /// `windows-byol` |
    /// `rhel` |
    /// `rhel-byol` |
    /// `rhel-high-availability` |
    /// `ubuntu-pro` |
    /// `suse-linux` |
    /// `sql-server-standard` |
    /// `sql-server-enterprise`.
    ///
    /// * `MarketPlaceProductCode` - The Marketplace product code.
    /// Logical operators are `EQUALS` and `NOT_EQUALS`.
    ///
    /// * `AMIId` - The ID of the AMI.
    /// Logical operators are `EQUALS` and `NOT_EQUALS`.
    ///
    /// * `InstanceType` - The instance type.
    /// Logical operators are `EQUALS` and `NOT_EQUALS`.
    ///
    /// * `InstanceId` - The ID of the instance.
    /// Logical operators are `EQUALS` and `NOT_EQUALS`.
    ///
    /// * `HostId` - The ID of the host.
    /// Logical operators are `EQUALS` and `NOT_EQUALS`.
    ///
    /// * `AccountId` - The ID of the account.
    /// Logical operators are `EQUALS` and `NOT_EQUALS`.
    ///
    /// The following keys and are supported when the RuleStatement type
    /// is `License`:
    ///
    /// * `LicenseArn` - The ARN of a Managed Entitlement License.
    /// Logical operators are `EQUALS` and `NOT_EQUALS`.
    ///
    /// * `ProductSKU` - The productSKU of the license.
    /// Logical operators are `EQUALS` and `NOT_EQUALS`.
    ///
    /// * `Issuer` - The issuer of the license.
    /// Logical operators are `EQUALS` and `NOT_EQUALS`.
    ///
    /// * `Beneficiary` - The beneficiary of the license.
    /// Logical operators are `EQUALS` and `NOT_EQUALS`.
    ///
    /// * `LicenseStatus` - The status of the license.
    /// Logical operators are `EQUALS` and `NOT_EQUALS`.
    ///
    /// * `HomeRegion` - The home region of the license.
    /// Logical operators are `EQUALS` and `NOT_EQUALS`.
    ///
    /// The following keys and are supported when the RuleStatement type
    /// is `License Configuration`:
    ///
    /// * `LicenseConfigurationArn` - The ARN of a self-managed license
    ///   configuration.
    /// Logical operators are `EQUALS` and `NOT_EQUALS`.
    ///
    /// * `AccountId` - The account of the license configuration.
    /// Logical operators are `EQUALS` and `NOT_EQUALS`.
    key_to_match: []const u8,

    /// Value to match.
    value_to_match: []const []const u8,

    pub const json_field_names = .{
        .constraint = "Constraint",
        .key_to_match = "KeyToMatch",
        .value_to_match = "ValueToMatch",
    };
};
