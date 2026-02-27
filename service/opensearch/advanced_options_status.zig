const aws = @import("aws");

const OptionStatus = @import("option_status.zig").OptionStatus;

/// Status of the advanced options for the specified domain. The following
/// options are
/// available:
///
/// * `"rest.action.multi.allow_explicit_index": "true" | "false"` - Note
/// the use of a string rather than a boolean. Specifies whether explicit
/// references
/// to indexes are allowed inside the body of HTTP requests. If you want to
/// configure access policies for domain sub-resources, such as specific indexes
/// and
/// domain APIs, you must disable this property. Default is true.
///
/// * `"indices.fielddata.cache.size": "80" ` - Note the use of a string
/// rather than a boolean. Specifies the percentage of heap space allocated to
/// field
/// data. Default is unbounded.
///
/// * `"indices.query.bool.max_clause_count": "1024"` - Note the use of a
/// string rather than a boolean. Specifies the maximum number of clauses
/// allowed in
/// a Lucene boolean query. Default is 1,024. Queries with more than the
/// permitted
/// number of clauses result in a `TooManyClauses` error.
///
/// * `"override_main_response_version": "true" | "false"` - Note the use
/// of a string rather than a boolean. Specifies whether the domain reports its
/// version as 7.10 to allow Elasticsearch OSS clients and plugins to continue
/// working with it. Default is false when creating a domain and true when
/// upgrading
/// a domain.
///
/// For more information, see [Advanced cluster
/// parameters](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/createupdatedomains.html#createdomain-configure-advanced-options).
pub const AdvancedOptionsStatus = struct {
    /// The status of advanced options for the specified domain.
    options: []const aws.map.StringMapEntry,

    /// The status of advanced options for the specified domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
