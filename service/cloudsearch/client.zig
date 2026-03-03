const aws = @import("aws");
const std = @import("std");

const build_suggesters = @import("build_suggesters.zig");
const create_domain = @import("create_domain.zig");
const define_analysis_scheme = @import("define_analysis_scheme.zig");
const define_expression = @import("define_expression.zig");
const define_index_field = @import("define_index_field.zig");
const define_suggester = @import("define_suggester.zig");
const delete_analysis_scheme = @import("delete_analysis_scheme.zig");
const delete_domain = @import("delete_domain.zig");
const delete_expression = @import("delete_expression.zig");
const delete_index_field = @import("delete_index_field.zig");
const delete_suggester = @import("delete_suggester.zig");
const describe_analysis_schemes = @import("describe_analysis_schemes.zig");
const describe_availability_options = @import("describe_availability_options.zig");
const describe_domain_endpoint_options = @import("describe_domain_endpoint_options.zig");
const describe_domains = @import("describe_domains.zig");
const describe_expressions = @import("describe_expressions.zig");
const describe_index_fields = @import("describe_index_fields.zig");
const describe_scaling_parameters = @import("describe_scaling_parameters.zig");
const describe_service_access_policies = @import("describe_service_access_policies.zig");
const describe_suggesters = @import("describe_suggesters.zig");
const index_documents = @import("index_documents.zig");
const list_domain_names = @import("list_domain_names.zig");
const update_availability_options = @import("update_availability_options.zig");
const update_domain_endpoint_options = @import("update_domain_endpoint_options.zig");
const update_scaling_parameters = @import("update_scaling_parameters.zig");
const update_service_access_policies = @import("update_service_access_policies.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CloudSearch";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Indexes the search suggestions. For more information, see [Configuring
    /// Suggesters](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/getting-suggestions.html#configuring-suggesters) in the *Amazon CloudSearch Developer Guide*.
    pub fn buildSuggesters(self: *Self, allocator: std.mem.Allocator, input: build_suggesters.BuildSuggestersInput, options: build_suggesters.Options) !build_suggesters.BuildSuggestersOutput {
        return build_suggesters.execute(self, allocator, input, options);
    }

    /// Creates a new search domain. For more information,
    /// see [Creating a Search
    /// Domain](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/creating-domains.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn createDomain(self: *Self, allocator: std.mem.Allocator, input: create_domain.CreateDomainInput, options: create_domain.Options) !create_domain.CreateDomainOutput {
        return create_domain.execute(self, allocator, input, options);
    }

    /// Configures an analysis scheme that can be applied to a `text` or
    /// `text-array` field to define language-specific text processing options. For
    /// more information, see [Configuring Analysis
    /// Schemes](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-analysis-schemes.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn defineAnalysisScheme(self: *Self, allocator: std.mem.Allocator, input: define_analysis_scheme.DefineAnalysisSchemeInput, options: define_analysis_scheme.Options) !define_analysis_scheme.DefineAnalysisSchemeOutput {
        return define_analysis_scheme.execute(self, allocator, input, options);
    }

    /// Configures an `Expression` for the search domain. Used to create new
    /// expressions and modify existing ones. If the expression exists, the new
    /// configuration replaces the old one. For more information, see [Configuring
    /// Expressions](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-expressions.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn defineExpression(self: *Self, allocator: std.mem.Allocator, input: define_expression.DefineExpressionInput, options: define_expression.Options) !define_expression.DefineExpressionOutput {
        return define_expression.execute(self, allocator, input, options);
    }

    /// Configures an `IndexField` for the search domain. Used to create new fields
    /// and modify existing ones. You must specify the name of the domain you are
    /// configuring and an index field configuration. The index field configuration
    /// specifies a unique name, the index field type, and the options you want to
    /// configure for the field. The options you can specify depend on the
    /// `IndexFieldType`. If the field exists, the new configuration replaces the
    /// old one. For more information, see [Configuring Index
    /// Fields](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-index-fields.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn defineIndexField(self: *Self, allocator: std.mem.Allocator, input: define_index_field.DefineIndexFieldInput, options: define_index_field.Options) !define_index_field.DefineIndexFieldOutput {
        return define_index_field.execute(self, allocator, input, options);
    }

    /// Configures a suggester for a domain. A suggester enables you to display
    /// possible matches before users finish typing their queries. When you
    /// configure a suggester, you must specify the name of the text field you want
    /// to search for possible matches and a unique name for the suggester. For more
    /// information, see [Getting Search
    /// Suggestions](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/getting-suggestions.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn defineSuggester(self: *Self, allocator: std.mem.Allocator, input: define_suggester.DefineSuggesterInput, options: define_suggester.Options) !define_suggester.DefineSuggesterOutput {
        return define_suggester.execute(self, allocator, input, options);
    }

    /// Deletes an analysis scheme. For more information, see [Configuring Analysis
    /// Schemes](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-analysis-schemes.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn deleteAnalysisScheme(self: *Self, allocator: std.mem.Allocator, input: delete_analysis_scheme.DeleteAnalysisSchemeInput, options: delete_analysis_scheme.Options) !delete_analysis_scheme.DeleteAnalysisSchemeOutput {
        return delete_analysis_scheme.execute(self, allocator, input, options);
    }

    /// Permanently deletes a search domain and all of its data. Once a domain has
    /// been deleted, it cannot be recovered. For more information,
    /// see [Deleting a Search
    /// Domain](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/deleting-domains.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn deleteDomain(self: *Self, allocator: std.mem.Allocator, input: delete_domain.DeleteDomainInput, options: delete_domain.Options) !delete_domain.DeleteDomainOutput {
        return delete_domain.execute(self, allocator, input, options);
    }

    /// Removes an `Expression` from the search domain. For more information, see
    /// [Configuring
    /// Expressions](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-expressions.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn deleteExpression(self: *Self, allocator: std.mem.Allocator, input: delete_expression.DeleteExpressionInput, options: delete_expression.Options) !delete_expression.DeleteExpressionOutput {
        return delete_expression.execute(self, allocator, input, options);
    }

    /// Removes an `IndexField` from the search domain. For more information, see
    /// [Configuring Index
    /// Fields](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-index-fields.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn deleteIndexField(self: *Self, allocator: std.mem.Allocator, input: delete_index_field.DeleteIndexFieldInput, options: delete_index_field.Options) !delete_index_field.DeleteIndexFieldOutput {
        return delete_index_field.execute(self, allocator, input, options);
    }

    /// Deletes a suggester. For more information, see [Getting Search
    /// Suggestions](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/getting-suggestions.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn deleteSuggester(self: *Self, allocator: std.mem.Allocator, input: delete_suggester.DeleteSuggesterInput, options: delete_suggester.Options) !delete_suggester.DeleteSuggesterOutput {
        return delete_suggester.execute(self, allocator, input, options);
    }

    /// Gets the analysis schemes configured for a domain. An analysis scheme
    /// defines language-specific text processing options for a `text` field. Can be
    /// limited to specific analysis schemes by name. By default, shows all analysis
    /// schemes and includes any pending changes to the configuration. Set the
    /// `Deployed` option to `true` to show the active configuration and exclude
    /// pending changes. For more information, see [Configuring Analysis
    /// Schemes](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-analysis-schemes.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn describeAnalysisSchemes(self: *Self, allocator: std.mem.Allocator, input: describe_analysis_schemes.DescribeAnalysisSchemesInput, options: describe_analysis_schemes.Options) !describe_analysis_schemes.DescribeAnalysisSchemesOutput {
        return describe_analysis_schemes.execute(self, allocator, input, options);
    }

    /// Gets the availability options configured for a domain. By default, shows the
    /// configuration with any pending changes. Set the `Deployed` option to `true`
    /// to show the active configuration and exclude pending changes. For more
    /// information, see [Configuring Availability
    /// Options](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-availability-options.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn describeAvailabilityOptions(self: *Self, allocator: std.mem.Allocator, input: describe_availability_options.DescribeAvailabilityOptionsInput, options: describe_availability_options.Options) !describe_availability_options.DescribeAvailabilityOptionsOutput {
        return describe_availability_options.execute(self, allocator, input, options);
    }

    /// Returns the domain's endpoint options, specifically whether all requests to
    /// the domain must arrive over HTTPS. For more information, see [Configuring
    /// Domain Endpoint
    /// Options](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-domain-endpoint-options.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn describeDomainEndpointOptions(self: *Self, allocator: std.mem.Allocator, input: describe_domain_endpoint_options.DescribeDomainEndpointOptionsInput, options: describe_domain_endpoint_options.Options) !describe_domain_endpoint_options.DescribeDomainEndpointOptionsOutput {
        return describe_domain_endpoint_options.execute(self, allocator, input, options);
    }

    /// Gets information about the search domains owned by this account. Can be
    /// limited to specific domains. Shows
    /// all domains by default. To get the number of searchable documents in a
    /// domain, use the console or submit a `matchall` request to your domain's
    /// search endpoint: `q=matchall&q.parser=structured&size=0`. For more
    /// information,
    /// see [Getting Information about a Search
    /// Domain](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/getting-domain-info.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn describeDomains(self: *Self, allocator: std.mem.Allocator, input: describe_domains.DescribeDomainsInput, options: describe_domains.Options) !describe_domains.DescribeDomainsOutput {
        return describe_domains.execute(self, allocator, input, options);
    }

    /// Gets the expressions configured for the search domain. Can be limited to
    /// specific expressions by name. By default, shows all expressions and includes
    /// any pending changes to the configuration. Set the `Deployed` option to
    /// `true` to show the active configuration and exclude pending changes. For
    /// more information, see [Configuring
    /// Expressions](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-expressions.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn describeExpressions(self: *Self, allocator: std.mem.Allocator, input: describe_expressions.DescribeExpressionsInput, options: describe_expressions.Options) !describe_expressions.DescribeExpressionsOutput {
        return describe_expressions.execute(self, allocator, input, options);
    }

    /// Gets information about the index fields configured for the search domain.
    /// Can be limited to specific fields by name. By default, shows all fields and
    /// includes any pending changes to the configuration. Set the `Deployed` option
    /// to `true` to show the active configuration and exclude pending changes. For
    /// more information,
    /// see [Getting Domain
    /// Information](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/getting-domain-info.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn describeIndexFields(self: *Self, allocator: std.mem.Allocator, input: describe_index_fields.DescribeIndexFieldsInput, options: describe_index_fields.Options) !describe_index_fields.DescribeIndexFieldsOutput {
        return describe_index_fields.execute(self, allocator, input, options);
    }

    /// Gets the scaling parameters configured for a domain. A domain's scaling
    /// parameters specify the desired search instance type and replication count.
    /// For more information, see [Configuring Scaling
    /// Options](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-scaling-options.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn describeScalingParameters(self: *Self, allocator: std.mem.Allocator, input: describe_scaling_parameters.DescribeScalingParametersInput, options: describe_scaling_parameters.Options) !describe_scaling_parameters.DescribeScalingParametersOutput {
        return describe_scaling_parameters.execute(self, allocator, input, options);
    }

    /// Gets information about the access policies that control access to the
    /// domain's document and search endpoints. By default, shows the configuration
    /// with any pending changes. Set the `Deployed` option to `true` to show the
    /// active configuration and exclude pending changes. For more information,
    /// see [Configuring Access for a Search
    /// Domain](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-access.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn describeServiceAccessPolicies(self: *Self, allocator: std.mem.Allocator, input: describe_service_access_policies.DescribeServiceAccessPoliciesInput, options: describe_service_access_policies.Options) !describe_service_access_policies.DescribeServiceAccessPoliciesOutput {
        return describe_service_access_policies.execute(self, allocator, input, options);
    }

    /// Gets the suggesters configured for a domain. A suggester enables you to
    /// display possible matches before users finish typing their queries. Can be
    /// limited to specific suggesters by name. By default, shows all suggesters and
    /// includes any pending changes to the configuration. Set the `Deployed` option
    /// to `true` to show the active configuration and exclude pending changes. For
    /// more information, see [Getting Search
    /// Suggestions](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/getting-suggestions.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn describeSuggesters(self: *Self, allocator: std.mem.Allocator, input: describe_suggesters.DescribeSuggestersInput, options: describe_suggesters.Options) !describe_suggesters.DescribeSuggestersOutput {
        return describe_suggesters.execute(self, allocator, input, options);
    }

    /// Tells the search domain to start indexing its documents using the latest
    /// indexing options. This operation must be invoked to activate options whose
    /// OptionStatus is `RequiresIndexDocuments`.
    pub fn indexDocuments(self: *Self, allocator: std.mem.Allocator, input: index_documents.IndexDocumentsInput, options: index_documents.Options) !index_documents.IndexDocumentsOutput {
        return index_documents.execute(self, allocator, input, options);
    }

    /// Lists all search domains owned by an account.
    pub fn listDomainNames(self: *Self, allocator: std.mem.Allocator, input: list_domain_names.ListDomainNamesInput, options: list_domain_names.Options) !list_domain_names.ListDomainNamesOutput {
        return list_domain_names.execute(self, allocator, input, options);
    }

    /// Configures the availability options for a domain. Enabling the Multi-AZ
    /// option expands an Amazon CloudSearch domain to an additional Availability
    /// Zone in the same Region to increase fault tolerance in the event of a
    /// service disruption. Changes to the Multi-AZ option can take about half an
    /// hour to become active. For more information, see [Configuring Availability
    /// Options](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-availability-options.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn updateAvailabilityOptions(self: *Self, allocator: std.mem.Allocator, input: update_availability_options.UpdateAvailabilityOptionsInput, options: update_availability_options.Options) !update_availability_options.UpdateAvailabilityOptionsOutput {
        return update_availability_options.execute(self, allocator, input, options);
    }

    /// Updates the domain's endpoint options, specifically whether all requests to
    /// the domain must arrive over HTTPS. For more information, see [Configuring
    /// Domain Endpoint
    /// Options](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-domain-endpoint-options.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn updateDomainEndpointOptions(self: *Self, allocator: std.mem.Allocator, input: update_domain_endpoint_options.UpdateDomainEndpointOptionsInput, options: update_domain_endpoint_options.Options) !update_domain_endpoint_options.UpdateDomainEndpointOptionsOutput {
        return update_domain_endpoint_options.execute(self, allocator, input, options);
    }

    /// Configures scaling parameters for a domain. A domain's scaling parameters
    /// specify the desired search instance type and replication count. Amazon
    /// CloudSearch will still automatically scale your domain based on the volume
    /// of data and traffic, but not below the desired instance type and replication
    /// count. If the Multi-AZ option is enabled, these values control the resources
    /// used per Availability Zone. For more information, see [Configuring Scaling
    /// Options](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-scaling-options.html) in the *Amazon CloudSearch Developer Guide*.
    pub fn updateScalingParameters(self: *Self, allocator: std.mem.Allocator, input: update_scaling_parameters.UpdateScalingParametersInput, options: update_scaling_parameters.Options) !update_scaling_parameters.UpdateScalingParametersOutput {
        return update_scaling_parameters.execute(self, allocator, input, options);
    }

    /// Configures the access rules that control access to the domain's document and
    /// search endpoints.
    /// For more information, see [
    /// Configuring Access for an Amazon CloudSearch
    /// Domain](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-access.html).
    pub fn updateServiceAccessPolicies(self: *Self, allocator: std.mem.Allocator, input: update_service_access_policies.UpdateServiceAccessPoliciesInput, options: update_service_access_policies.Options) !update_service_access_policies.UpdateServiceAccessPoliciesOutput {
        return update_service_access_policies.execute(self, allocator, input, options);
    }
};
