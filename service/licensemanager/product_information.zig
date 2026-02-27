const ProductInformationFilter = @import("product_information_filter.zig").ProductInformationFilter;

/// Describes product information for a license configuration.
pub const ProductInformation = struct {
    /// A Product information filter consists of a
    /// `ProductInformationFilterComparator` which is a logical operator, a
    /// `ProductInformationFilterName` which specifies the type of filter being
    /// declared, and a `ProductInformationFilterValue` that specifies the value to
    /// filter on.
    ///
    /// Accepted values for `ProductInformationFilterName` are listed here along
    /// with descriptions and valid options for
    /// `ProductInformationFilterComparator`.
    ///
    /// The following filters and are supported when the resource type
    /// is `SSM_MANAGED`:
    ///
    /// * `Application Name` - The name of the application.
    /// Logical operator is `EQUALS`.
    ///
    /// * `Application Publisher` - The publisher of the application.
    /// Logical operator is `EQUALS`.
    ///
    /// * `Application Version` - The version of the application.
    /// Logical operator is `EQUALS`.
    ///
    /// * `Platform Name` - The name of the platform.
    /// Logical operator is `EQUALS`.
    ///
    /// * `Platform Type` - The platform type.
    /// Logical operator is `EQUALS`.
    ///
    /// * `Tag:key` - The key of a tag attached to an Amazon Web Services resource
    ///   you wish to exclude from automated discovery. Logical operator is
    ///   `NOT_EQUALS`. The key for your tag must be appended to `Tag:` following
    ///   the example: `Tag:name-of-your-key`. `ProductInformationFilterValue` is
    ///   optional if you are not using values for the key.
    ///
    /// * `AccountId` - The 12-digit ID of an Amazon Web Services account you wish
    ///   to exclude from automated discovery.
    /// Logical operator is `NOT_EQUALS`.
    ///
    /// * `License Included` - The type of license included.
    /// Logical operators are `EQUALS` and `NOT_EQUALS`.
    /// Possible values are: `sql-server-enterprise` |
    /// `sql-server-standard` |
    /// `sql-server-web` |
    /// `windows-server-datacenter`.
    ///
    /// The following filters and logical operators are supported when the resource
    /// type
    /// is `RDS`:
    ///
    /// * `Engine Edition` - The edition of the database engine.
    /// Logical operator is `EQUALS`.
    /// Possible values are: `oracle-ee` | `oracle-se` | `oracle-se1` | `oracle-se2`
    /// | `db2-se` | `db2-ae`.
    ///
    /// * `License Pack` - The license pack.
    /// Logical operator is `EQUALS`.
    /// Possible values are: `data guard` |
    /// `diagnostic pack sqlt` |
    /// `tuning pack sqlt` |
    /// `ols` |
    /// `olap`.
    product_information_filter_list: []const ProductInformationFilter,

    /// Resource type. The possible values are `SSM_MANAGED` | `RDS`.
    resource_type: []const u8,

    pub const json_field_names = .{
        .product_information_filter_list = "ProductInformationFilterList",
        .resource_type = "ResourceType",
    };
};
