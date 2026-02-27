const aws = @import("aws");
const std = @import("std");

const create_byte_match_set = @import("create_byte_match_set.zig");
const create_geo_match_set = @import("create_geo_match_set.zig");
const create_ip_set = @import("create_ip_set.zig");
const create_rate_based_rule = @import("create_rate_based_rule.zig");
const create_regex_match_set = @import("create_regex_match_set.zig");
const create_regex_pattern_set = @import("create_regex_pattern_set.zig");
const create_rule = @import("create_rule.zig");
const create_rule_group = @import("create_rule_group.zig");
const create_size_constraint_set = @import("create_size_constraint_set.zig");
const create_sql_injection_match_set = @import("create_sql_injection_match_set.zig");
const create_web_acl = @import("create_web_acl.zig");
const create_web_acl_migration_stack = @import("create_web_acl_migration_stack.zig");
const create_xss_match_set = @import("create_xss_match_set.zig");
const delete_byte_match_set = @import("delete_byte_match_set.zig");
const delete_geo_match_set = @import("delete_geo_match_set.zig");
const delete_ip_set = @import("delete_ip_set.zig");
const delete_logging_configuration = @import("delete_logging_configuration.zig");
const delete_permission_policy = @import("delete_permission_policy.zig");
const delete_rate_based_rule = @import("delete_rate_based_rule.zig");
const delete_regex_match_set = @import("delete_regex_match_set.zig");
const delete_regex_pattern_set = @import("delete_regex_pattern_set.zig");
const delete_rule = @import("delete_rule.zig");
const delete_rule_group = @import("delete_rule_group.zig");
const delete_size_constraint_set = @import("delete_size_constraint_set.zig");
const delete_sql_injection_match_set = @import("delete_sql_injection_match_set.zig");
const delete_web_acl = @import("delete_web_acl.zig");
const delete_xss_match_set = @import("delete_xss_match_set.zig");
const get_byte_match_set = @import("get_byte_match_set.zig");
const get_change_token = @import("get_change_token.zig");
const get_change_token_status = @import("get_change_token_status.zig");
const get_geo_match_set = @import("get_geo_match_set.zig");
const get_ip_set = @import("get_ip_set.zig");
const get_logging_configuration = @import("get_logging_configuration.zig");
const get_permission_policy = @import("get_permission_policy.zig");
const get_rate_based_rule = @import("get_rate_based_rule.zig");
const get_rate_based_rule_managed_keys = @import("get_rate_based_rule_managed_keys.zig");
const get_regex_match_set = @import("get_regex_match_set.zig");
const get_regex_pattern_set = @import("get_regex_pattern_set.zig");
const get_rule = @import("get_rule.zig");
const get_rule_group = @import("get_rule_group.zig");
const get_sampled_requests = @import("get_sampled_requests.zig");
const get_size_constraint_set = @import("get_size_constraint_set.zig");
const get_sql_injection_match_set = @import("get_sql_injection_match_set.zig");
const get_web_acl = @import("get_web_acl.zig");
const get_xss_match_set = @import("get_xss_match_set.zig");
const list_activated_rules_in_rule_group = @import("list_activated_rules_in_rule_group.zig");
const list_byte_match_sets = @import("list_byte_match_sets.zig");
const list_geo_match_sets = @import("list_geo_match_sets.zig");
const list_ip_sets = @import("list_ip_sets.zig");
const list_logging_configurations = @import("list_logging_configurations.zig");
const list_rate_based_rules = @import("list_rate_based_rules.zig");
const list_regex_match_sets = @import("list_regex_match_sets.zig");
const list_regex_pattern_sets = @import("list_regex_pattern_sets.zig");
const list_rule_groups = @import("list_rule_groups.zig");
const list_rules = @import("list_rules.zig");
const list_size_constraint_sets = @import("list_size_constraint_sets.zig");
const list_sql_injection_match_sets = @import("list_sql_injection_match_sets.zig");
const list_subscribed_rule_groups = @import("list_subscribed_rule_groups.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_web_ac_ls = @import("list_web_ac_ls.zig");
const list_xss_match_sets = @import("list_xss_match_sets.zig");
const put_logging_configuration = @import("put_logging_configuration.zig");
const put_permission_policy = @import("put_permission_policy.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_byte_match_set = @import("update_byte_match_set.zig");
const update_geo_match_set = @import("update_geo_match_set.zig");
const update_ip_set = @import("update_ip_set.zig");
const update_rate_based_rule = @import("update_rate_based_rule.zig");
const update_regex_match_set = @import("update_regex_match_set.zig");
const update_regex_pattern_set = @import("update_regex_pattern_set.zig");
const update_rule = @import("update_rule.zig");
const update_rule_group = @import("update_rule_group.zig");
const update_size_constraint_set = @import("update_size_constraint_set.zig");
const update_sql_injection_match_set = @import("update_sql_injection_match_set.zig");
const update_web_acl = @import("update_web_acl.zig");
const update_xss_match_set = @import("update_xss_match_set.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "WAF";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Creates a `ByteMatchSet`. You then use UpdateByteMatchSet to identify the
    /// part of a
    /// web request that you want AWS WAF to inspect, such as the values of the
    /// `User-Agent` header or the query string.
    /// For example, you can create a `ByteMatchSet` that matches any requests with
    /// `User-Agent` headers
    /// that contain the string `BadBot`. You can then configure AWS WAF to reject
    /// those requests.
    ///
    /// To create and configure a `ByteMatchSet`, perform the following steps:
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `CreateByteMatchSet` request.
    ///
    /// * Submit a `CreateByteMatchSet` request.
    ///
    /// * Use `GetChangeToken` to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// `UpdateByteMatchSet` request.
    ///
    /// * Submit an UpdateByteMatchSet request to specify the part of the request
    ///   that you want AWS WAF to inspect
    /// (for example, the header or the URI) and the value that you want AWS WAF to
    /// watch for.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the
    /// [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn createByteMatchSet(self: *Self, allocator: std.mem.Allocator, input: create_byte_match_set.CreateByteMatchSetInput, options: create_byte_match_set.Options) !create_byte_match_set.CreateByteMatchSetOutput {
        return create_byte_match_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Creates an GeoMatchSet, which you use to specify which web requests you want
    /// to allow or block based on the country
    /// that the requests originate from. For example, if you're receiving a lot of
    /// requests from one or more countries and you want to block the requests, you
    /// can create an `GeoMatchSet` that contains those countries and then configure
    /// AWS WAF to block the requests.
    ///
    /// To create and configure a `GeoMatchSet`, perform the following steps:
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `CreateGeoMatchSet` request.
    ///
    /// * Submit a `CreateGeoMatchSet` request.
    ///
    /// * Use `GetChangeToken` to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// UpdateGeoMatchSet request.
    ///
    /// * Submit an `UpdateGeoMatchSetSet` request to specify the countries that you
    ///   want AWS WAF to watch for.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the
    /// [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn createGeoMatchSet(self: *Self, allocator: std.mem.Allocator, input: create_geo_match_set.CreateGeoMatchSetInput, options: create_geo_match_set.Options) !create_geo_match_set.CreateGeoMatchSetOutput {
        return create_geo_match_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Creates an IPSet, which you use to specify which web requests
    /// that
    /// you want to allow or block based on the IP addresses that the requests
    /// originate from. For example, if you're receiving a lot of requests from one
    /// or more
    /// individual IP addresses or one or more ranges of IP addresses and you want
    /// to block the
    /// requests, you can create an `IPSet` that contains those IP addresses and
    /// then
    /// configure AWS WAF to block the requests.
    ///
    /// To create and configure an `IPSet`, perform the following steps:
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `CreateIPSet` request.
    ///
    /// * Submit a `CreateIPSet` request.
    ///
    /// * Use `GetChangeToken` to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// UpdateIPSet request.
    ///
    /// * Submit an `UpdateIPSet` request to specify the IP addresses that you want
    ///   AWS WAF to watch for.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the
    /// [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn createIpSet(self: *Self, allocator: std.mem.Allocator, input: create_ip_set.CreateIPSetInput, options: create_ip_set.Options) !create_ip_set.CreateIPSetOutput {
        return create_ip_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Creates a RateBasedRule. The `RateBasedRule` contains a
    /// `RateLimit`, which specifies the maximum number of requests that AWS WAF
    /// allows
    /// from a specified IP address in a five-minute period.
    /// The `RateBasedRule` also
    /// contains the `IPSet` objects, `ByteMatchSet` objects, and other
    /// predicates that identify the requests that you want to count or block if
    /// these requests
    /// exceed the `RateLimit`.
    ///
    /// If you add more than one predicate to a `RateBasedRule`, a request not
    /// only must exceed the `RateLimit`, but it also must match all the
    /// conditions to be counted or blocked. For example, suppose you add the
    /// following to a
    /// `RateBasedRule`:
    ///
    /// * An `IPSet` that matches the IP address `192.0.2.44/32`
    ///
    /// * A `ByteMatchSet` that matches `BadBot` in the
    /// `User-Agent` header
    ///
    /// Further, you specify a `RateLimit` of 1,000.
    ///
    /// You then add the `RateBasedRule` to a `WebACL` and specify that
    /// you want to block requests that meet the conditions in the rule. For a
    /// request to be
    /// blocked, it must come from the IP address 192.0.2.44 *and* the
    /// `User-Agent` header in the request must contain the value
    /// `BadBot`. Further, requests that match these two conditions must be received
    /// at
    /// a rate of more than 1,000 requests every five minutes. If both conditions
    /// are met and the
    /// rate is exceeded, AWS WAF blocks the requests. If the rate drops below 1,000
    /// for a
    /// five-minute period, AWS WAF no longer blocks the requests.
    ///
    /// As a second example, suppose you want to limit requests to a particular page
    /// on your site. To do this, you could add the following to a
    /// `RateBasedRule`:
    ///
    /// * A `ByteMatchSet` with `FieldToMatch` of `URI`
    ///
    /// * A `PositionalConstraint` of `STARTS_WITH`
    ///
    /// * A `TargetString` of `login`
    ///
    /// Further, you specify a `RateLimit` of 1,000.
    ///
    /// By adding this `RateBasedRule` to a `WebACL`, you could limit requests to
    /// your login page without affecting the rest of your site.
    ///
    /// To create and configure a `RateBasedRule`, perform the following
    /// steps:
    ///
    /// * Create and update the predicates that you want to include in the rule. For
    ///   more
    /// information, see CreateByteMatchSet, CreateIPSet,
    /// and CreateSqlInjectionMatchSet.
    ///
    /// * Use GetChangeToken to get the change token that you provide
    /// in the `ChangeToken` parameter of a `CreateRule`
    /// request.
    ///
    /// * Submit a `CreateRateBasedRule` request.
    ///
    /// * Use `GetChangeToken` to get the change token that you provide in the
    /// `ChangeToken` parameter of an UpdateRule
    /// request.
    ///
    /// * Submit an `UpdateRateBasedRule` request to specify the predicates
    /// that you want to include in the rule.
    ///
    /// * Create and update a `WebACL` that contains the
    /// `RateBasedRule`. For more information, see CreateWebACL.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests,
    /// see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn createRateBasedRule(self: *Self, allocator: std.mem.Allocator, input: create_rate_based_rule.CreateRateBasedRuleInput, options: create_rate_based_rule.Options) !create_rate_based_rule.CreateRateBasedRuleOutput {
        return create_rate_based_rule.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Creates a RegexMatchSet. You then use UpdateRegexMatchSet to identify the
    /// part of a
    /// web request that you want AWS WAF to inspect, such as the values of the
    /// `User-Agent` header or the query string.
    /// For example, you can create a `RegexMatchSet` that contains a
    /// `RegexMatchTuple` that looks for any requests with `User-Agent` headers
    /// that match a `RegexPatternSet` with pattern `B[a@]dB[o0]t`. You can then
    /// configure AWS WAF to reject those requests.
    ///
    /// To create and configure a `RegexMatchSet`, perform the following steps:
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `CreateRegexMatchSet` request.
    ///
    /// * Submit a `CreateRegexMatchSet` request.
    ///
    /// * Use `GetChangeToken` to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// `UpdateRegexMatchSet` request.
    ///
    /// * Submit an UpdateRegexMatchSet request to specify the part of the request
    ///   that you want AWS WAF to inspect
    /// (for example, the header or the URI) and the value, using a
    /// `RegexPatternSet`, that you want AWS WAF to watch for.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the
    /// [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn createRegexMatchSet(self: *Self, allocator: std.mem.Allocator, input: create_regex_match_set.CreateRegexMatchSetInput, options: create_regex_match_set.Options) !create_regex_match_set.CreateRegexMatchSetOutput {
        return create_regex_match_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Creates a `RegexPatternSet`. You then use UpdateRegexPatternSet to specify
    /// the regular expression (regex) pattern that you want AWS WAF to search for,
    /// such as `B[a@]dB[o0]t`. You can then configure AWS WAF to reject those
    /// requests.
    ///
    /// To create and configure a `RegexPatternSet`, perform the following steps:
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `CreateRegexPatternSet` request.
    ///
    /// * Submit a `CreateRegexPatternSet` request.
    ///
    /// * Use `GetChangeToken` to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// `UpdateRegexPatternSet` request.
    ///
    /// * Submit an UpdateRegexPatternSet request to specify the string that you
    ///   want AWS WAF to watch for.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the
    /// [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn createRegexPatternSet(self: *Self, allocator: std.mem.Allocator, input: create_regex_pattern_set.CreateRegexPatternSetInput, options: create_regex_pattern_set.Options) !create_regex_pattern_set.CreateRegexPatternSetOutput {
        return create_regex_pattern_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Creates a `Rule`, which contains the `IPSet` objects,
    /// `ByteMatchSet` objects, and other predicates that identify the requests that
    /// you want to block. If you add more than one predicate to a `Rule`, a request
    /// must match all of the specifications to be allowed or blocked. For example,
    /// suppose
    /// that
    /// you add the following to a `Rule`:
    ///
    /// * An `IPSet` that matches the IP address `192.0.2.44/32`
    ///
    /// * A `ByteMatchSet` that matches `BadBot` in the `User-Agent` header
    ///
    /// You then add the `Rule` to a `WebACL` and specify that you want to blocks
    /// requests that satisfy the `Rule`.
    /// For a request to be blocked, it must come from the IP address 192.0.2.44
    /// *and* the `User-Agent` header in the request
    /// must contain the value `BadBot`.
    ///
    /// To create and configure a `Rule`, perform the following steps:
    ///
    /// * Create and update the predicates that you want to include in the `Rule`.
    ///   For more information, see
    /// CreateByteMatchSet, CreateIPSet, and CreateSqlInjectionMatchSet.
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `CreateRule` request.
    ///
    /// * Submit a `CreateRule` request.
    ///
    /// * Use `GetChangeToken` to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// UpdateRule request.
    ///
    /// * Submit an `UpdateRule` request to specify the predicates that you want to
    ///   include in the `Rule`.
    ///
    /// * Create and update a `WebACL` that contains the `Rule`. For more
    ///   information, see CreateWebACL.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the
    /// [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn createRule(self: *Self, allocator: std.mem.Allocator, input: create_rule.CreateRuleInput, options: create_rule.Options) !create_rule.CreateRuleOutput {
        return create_rule.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Creates a `RuleGroup`. A rule group is a collection of predefined rules that
    /// you add to a web ACL. You use UpdateRuleGroup to add rules to the rule
    /// group.
    ///
    /// Rule groups are subject to the following limits:
    ///
    /// * Three rule groups per account. You can request an increase to this limit
    ///   by contacting customer support.
    ///
    /// * One rule group per web ACL.
    ///
    /// * Ten rules per rule group.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the
    /// [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn createRuleGroup(self: *Self, allocator: std.mem.Allocator, input: create_rule_group.CreateRuleGroupInput, options: create_rule_group.Options) !create_rule_group.CreateRuleGroupOutput {
        return create_rule_group.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Creates a `SizeConstraintSet`. You then use UpdateSizeConstraintSet to
    /// identify the part of a
    /// web request that you want AWS WAF to check for length, such as the length of
    /// the `User-Agent` header or the length of the query string.
    /// For example, you can create a `SizeConstraintSet` that matches any requests
    /// that have a query string that is longer than 100 bytes.
    /// You can then configure AWS WAF to reject those requests.
    ///
    /// To create and configure a `SizeConstraintSet`, perform the following steps:
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `CreateSizeConstraintSet` request.
    ///
    /// * Submit a `CreateSizeConstraintSet` request.
    ///
    /// * Use `GetChangeToken` to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// `UpdateSizeConstraintSet` request.
    ///
    /// * Submit an UpdateSizeConstraintSet request to specify the part of the
    ///   request that you want AWS WAF to inspect
    /// (for example, the header or the URI) and the value that you want AWS WAF to
    /// watch for.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the
    /// [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn createSizeConstraintSet(self: *Self, allocator: std.mem.Allocator, input: create_size_constraint_set.CreateSizeConstraintSetInput, options: create_size_constraint_set.Options) !create_size_constraint_set.CreateSizeConstraintSetOutput {
        return create_size_constraint_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Creates a SqlInjectionMatchSet, which you use to allow, block, or count
    /// requests that contain snippets of SQL code in a
    /// specified part of web requests. AWS WAF searches for character sequences
    /// that are likely to be malicious strings.
    ///
    /// To create and configure a `SqlInjectionMatchSet`, perform the following
    /// steps:
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `CreateSqlInjectionMatchSet` request.
    ///
    /// * Submit a `CreateSqlInjectionMatchSet` request.
    ///
    /// * Use `GetChangeToken` to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// UpdateSqlInjectionMatchSet request.
    ///
    /// * Submit an UpdateSqlInjectionMatchSet request to specify the parts of web
    ///   requests in which you want to
    /// allow, block, or count malicious SQL code.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the
    /// [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn createSqlInjectionMatchSet(self: *Self, allocator: std.mem.Allocator, input: create_sql_injection_match_set.CreateSqlInjectionMatchSetInput, options: create_sql_injection_match_set.Options) !create_sql_injection_match_set.CreateSqlInjectionMatchSetOutput {
        return create_sql_injection_match_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Creates a `WebACL`, which contains the `Rules` that identify the CloudFront
    /// web requests that you want to allow, block, or count.
    /// AWS WAF evaluates `Rules` in order based on the value of `Priority` for each
    /// `Rule`.
    ///
    /// You also specify a default action, either `ALLOW` or `BLOCK`. If a web
    /// request doesn't match
    /// any of the `Rules` in a `WebACL`, AWS WAF responds to the request with the
    /// default action.
    ///
    /// To create and configure a `WebACL`, perform the following steps:
    ///
    /// * Create and update the `ByteMatchSet` objects and other predicates that you
    ///   want to include in `Rules`.
    /// For more information, see CreateByteMatchSet, UpdateByteMatchSet,
    /// CreateIPSet, UpdateIPSet,
    /// CreateSqlInjectionMatchSet, and UpdateSqlInjectionMatchSet.
    ///
    /// * Create and update the `Rules` that you want to include in the `WebACL`.
    ///   For more information, see
    /// CreateRule and UpdateRule.
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `CreateWebACL` request.
    ///
    /// * Submit a `CreateWebACL` request.
    ///
    /// * Use `GetChangeToken` to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// UpdateWebACL request.
    ///
    /// * Submit an UpdateWebACL request to specify the `Rules` that you want to
    ///   include in the `WebACL`,
    /// to specify the default action, and to associate the `WebACL` with a
    /// CloudFront distribution.
    ///
    /// For more information about how to use the AWS WAF API, see the [AWS WAF
    /// Developer Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn createWebAcl(self: *Self, allocator: std.mem.Allocator, input: create_web_acl.CreateWebACLInput, options: create_web_acl.Options) !create_web_acl.CreateWebACLOutput {
        return create_web_acl.execute(self, allocator, input, options);
    }

    /// Creates an AWS CloudFormation WAFV2 template for the specified web ACL in
    /// the specified Amazon S3 bucket.
    /// Then, in CloudFormation, you create a stack from the template, to create the
    /// web ACL and its resources in AWS WAFV2.
    /// Use this to migrate your AWS WAF Classic web ACL to the latest version of
    /// AWS WAF.
    ///
    /// This is part of a larger migration procedure for web ACLs from AWS WAF
    /// Classic to the latest version of AWS WAF.
    /// For the full procedure, including caveats and manual steps to complete
    /// the migration and switch over to the new web ACL, see
    /// [Migrating your AWS WAF Classic resources to AWS
    /// WAF](https://docs.aws.amazon.com/waf/latest/developerguide/waf-migrating-from-classic.html) in the [AWS WAF
    /// Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html).
    pub fn createWebAclMigrationStack(self: *Self, allocator: std.mem.Allocator, input: create_web_acl_migration_stack.CreateWebACLMigrationStackInput, options: create_web_acl_migration_stack.Options) !create_web_acl_migration_stack.CreateWebACLMigrationStackOutput {
        return create_web_acl_migration_stack.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Creates an XssMatchSet, which you use to allow, block, or count requests
    /// that contain cross-site scripting attacks
    /// in the specified part of web requests. AWS WAF searches for character
    /// sequences that are likely to be malicious strings.
    ///
    /// To create and configure an `XssMatchSet`, perform the following steps:
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `CreateXssMatchSet` request.
    ///
    /// * Submit a `CreateXssMatchSet` request.
    ///
    /// * Use `GetChangeToken` to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// UpdateXssMatchSet request.
    ///
    /// * Submit an UpdateXssMatchSet request to specify the parts of web requests
    ///   in which you want to
    /// allow, block, or count cross-site scripting attacks.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the
    /// [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn createXssMatchSet(self: *Self, allocator: std.mem.Allocator, input: create_xss_match_set.CreateXssMatchSetInput, options: create_xss_match_set.Options) !create_xss_match_set.CreateXssMatchSetOutput {
        return create_xss_match_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Permanently deletes a ByteMatchSet. You can't delete a `ByteMatchSet` if
    /// it's still used in any `Rules`
    /// or if it still includes any ByteMatchTuple objects (any filters).
    ///
    /// If you just want to remove a `ByteMatchSet` from a `Rule`, use UpdateRule.
    ///
    /// To permanently delete a `ByteMatchSet`, perform the following steps:
    ///
    /// * Update the `ByteMatchSet` to remove filters, if any. For more information,
    ///   see UpdateByteMatchSet.
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `DeleteByteMatchSet` request.
    ///
    /// * Submit a `DeleteByteMatchSet` request.
    pub fn deleteByteMatchSet(self: *Self, allocator: std.mem.Allocator, input: delete_byte_match_set.DeleteByteMatchSetInput, options: delete_byte_match_set.Options) !delete_byte_match_set.DeleteByteMatchSetOutput {
        return delete_byte_match_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Permanently deletes a GeoMatchSet. You can't delete a `GeoMatchSet` if it's
    /// still used in any `Rules` or
    /// if it still includes any countries.
    ///
    /// If you just want to remove a `GeoMatchSet` from a `Rule`, use UpdateRule.
    ///
    /// To permanently delete a `GeoMatchSet` from AWS WAF, perform the following
    /// steps:
    ///
    /// * Update the `GeoMatchSet` to remove any countries. For more information,
    ///   see UpdateGeoMatchSet.
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `DeleteGeoMatchSet` request.
    ///
    /// * Submit a `DeleteGeoMatchSet` request.
    pub fn deleteGeoMatchSet(self: *Self, allocator: std.mem.Allocator, input: delete_geo_match_set.DeleteGeoMatchSetInput, options: delete_geo_match_set.Options) !delete_geo_match_set.DeleteGeoMatchSetOutput {
        return delete_geo_match_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Permanently deletes an IPSet. You can't delete an `IPSet` if it's still used
    /// in any `Rules` or
    /// if it still includes any IP addresses.
    ///
    /// If you just want to remove an `IPSet` from a `Rule`, use UpdateRule.
    ///
    /// To permanently delete an `IPSet` from AWS WAF, perform the following steps:
    ///
    /// * Update the `IPSet` to remove IP address ranges, if any. For more
    ///   information, see UpdateIPSet.
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `DeleteIPSet` request.
    ///
    /// * Submit a `DeleteIPSet` request.
    pub fn deleteIpSet(self: *Self, allocator: std.mem.Allocator, input: delete_ip_set.DeleteIPSetInput, options: delete_ip_set.Options) !delete_ip_set.DeleteIPSetOutput {
        return delete_ip_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Permanently deletes the LoggingConfiguration from the specified web
    /// ACL.
    pub fn deleteLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_logging_configuration.DeleteLoggingConfigurationInput, options: delete_logging_configuration.Options) !delete_logging_configuration.DeleteLoggingConfigurationOutput {
        return delete_logging_configuration.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Permanently deletes an IAM policy from the specified RuleGroup.
    ///
    /// The user making the request must be the owner of the RuleGroup.
    pub fn deletePermissionPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_permission_policy.DeletePermissionPolicyInput, options: delete_permission_policy.Options) !delete_permission_policy.DeletePermissionPolicyOutput {
        return delete_permission_policy.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Permanently deletes a RateBasedRule. You can't delete a rule if
    /// it's still used in any `WebACL` objects or if it still includes any
    /// predicates,
    /// such as `ByteMatchSet` objects.
    ///
    /// If you just want to remove a rule from a `WebACL`, use UpdateWebACL.
    ///
    /// To permanently delete a `RateBasedRule` from AWS WAF, perform the following
    /// steps:
    ///
    /// * Update the `RateBasedRule` to remove predicates, if any. For more
    /// information, see UpdateRateBasedRule.
    ///
    /// * Use GetChangeToken to get the change token that you provide
    /// in the `ChangeToken` parameter of a `DeleteRateBasedRule`
    /// request.
    ///
    /// * Submit a `DeleteRateBasedRule` request.
    pub fn deleteRateBasedRule(self: *Self, allocator: std.mem.Allocator, input: delete_rate_based_rule.DeleteRateBasedRuleInput, options: delete_rate_based_rule.Options) !delete_rate_based_rule.DeleteRateBasedRuleOutput {
        return delete_rate_based_rule.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Permanently deletes a RegexMatchSet. You can't delete a `RegexMatchSet` if
    /// it's still used in any `Rules`
    /// or if it still includes any `RegexMatchTuples` objects (any filters).
    ///
    /// If you just want to remove a `RegexMatchSet` from a `Rule`, use UpdateRule.
    ///
    /// To permanently delete a `RegexMatchSet`, perform the following steps:
    ///
    /// * Update the `RegexMatchSet` to remove filters, if any. For more
    ///   information, see UpdateRegexMatchSet.
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `DeleteRegexMatchSet` request.
    ///
    /// * Submit a `DeleteRegexMatchSet` request.
    pub fn deleteRegexMatchSet(self: *Self, allocator: std.mem.Allocator, input: delete_regex_match_set.DeleteRegexMatchSetInput, options: delete_regex_match_set.Options) !delete_regex_match_set.DeleteRegexMatchSetOutput {
        return delete_regex_match_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Permanently deletes a RegexPatternSet. You can't delete a `RegexPatternSet`
    /// if it's still used in any `RegexMatchSet`
    /// or if the `RegexPatternSet` is not empty.
    pub fn deleteRegexPatternSet(self: *Self, allocator: std.mem.Allocator, input: delete_regex_pattern_set.DeleteRegexPatternSetInput, options: delete_regex_pattern_set.Options) !delete_regex_pattern_set.DeleteRegexPatternSetOutput {
        return delete_regex_pattern_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Permanently deletes a Rule. You can't delete a `Rule` if it's still used in
    /// any `WebACL`
    /// objects or if it still includes any predicates, such as `ByteMatchSet`
    /// objects.
    ///
    /// If you just want to remove a `Rule` from a `WebACL`, use UpdateWebACL.
    ///
    /// To permanently delete a `Rule` from AWS WAF, perform the following steps:
    ///
    /// * Update the `Rule` to remove predicates, if any. For more information, see
    ///   UpdateRule.
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `DeleteRule` request.
    ///
    /// * Submit a `DeleteRule` request.
    pub fn deleteRule(self: *Self, allocator: std.mem.Allocator, input: delete_rule.DeleteRuleInput, options: delete_rule.Options) !delete_rule.DeleteRuleOutput {
        return delete_rule.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Permanently deletes a RuleGroup. You can't delete a `RuleGroup` if it's
    /// still used in any `WebACL`
    /// objects or if it still includes any rules.
    ///
    /// If you just want to remove a `RuleGroup` from a `WebACL`, use UpdateWebACL.
    ///
    /// To permanently delete a `RuleGroup` from AWS WAF, perform the following
    /// steps:
    ///
    /// * Update the `RuleGroup` to remove rules, if any. For more information, see
    ///   UpdateRuleGroup.
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `DeleteRuleGroup` request.
    ///
    /// * Submit a `DeleteRuleGroup` request.
    pub fn deleteRuleGroup(self: *Self, allocator: std.mem.Allocator, input: delete_rule_group.DeleteRuleGroupInput, options: delete_rule_group.Options) !delete_rule_group.DeleteRuleGroupOutput {
        return delete_rule_group.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Permanently deletes a SizeConstraintSet. You can't delete a
    /// `SizeConstraintSet` if it's still used in any `Rules`
    /// or if it still includes any SizeConstraint objects (any filters).
    ///
    /// If you just want to remove a `SizeConstraintSet` from a `Rule`, use
    /// UpdateRule.
    ///
    /// To permanently delete a `SizeConstraintSet`, perform the following steps:
    ///
    /// * Update the `SizeConstraintSet` to remove filters, if any. For more
    ///   information, see UpdateSizeConstraintSet.
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `DeleteSizeConstraintSet` request.
    ///
    /// * Submit a `DeleteSizeConstraintSet` request.
    pub fn deleteSizeConstraintSet(self: *Self, allocator: std.mem.Allocator, input: delete_size_constraint_set.DeleteSizeConstraintSetInput, options: delete_size_constraint_set.Options) !delete_size_constraint_set.DeleteSizeConstraintSetOutput {
        return delete_size_constraint_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Permanently deletes a SqlInjectionMatchSet. You can't delete a
    /// `SqlInjectionMatchSet` if it's
    /// still used in any `Rules` or if it still contains any SqlInjectionMatchTuple
    /// objects.
    ///
    /// If you just want to remove a `SqlInjectionMatchSet` from a `Rule`, use
    /// UpdateRule.
    ///
    /// To permanently delete a `SqlInjectionMatchSet` from AWS WAF, perform the
    /// following steps:
    ///
    /// * Update the `SqlInjectionMatchSet` to remove filters, if any. For more
    ///   information, see
    /// UpdateSqlInjectionMatchSet.
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `DeleteSqlInjectionMatchSet` request.
    ///
    /// * Submit a `DeleteSqlInjectionMatchSet` request.
    pub fn deleteSqlInjectionMatchSet(self: *Self, allocator: std.mem.Allocator, input: delete_sql_injection_match_set.DeleteSqlInjectionMatchSetInput, options: delete_sql_injection_match_set.Options) !delete_sql_injection_match_set.DeleteSqlInjectionMatchSetOutput {
        return delete_sql_injection_match_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Permanently deletes a WebACL. You can't delete a `WebACL` if it still
    /// contains any `Rules`.
    ///
    /// To delete a `WebACL`, perform the following steps:
    ///
    /// * Update the `WebACL` to remove `Rules`, if any. For more information, see
    ///   UpdateWebACL.
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `DeleteWebACL` request.
    ///
    /// * Submit a `DeleteWebACL` request.
    pub fn deleteWebAcl(self: *Self, allocator: std.mem.Allocator, input: delete_web_acl.DeleteWebACLInput, options: delete_web_acl.Options) !delete_web_acl.DeleteWebACLOutput {
        return delete_web_acl.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Permanently deletes an XssMatchSet. You can't delete an `XssMatchSet` if
    /// it's
    /// still used in any `Rules` or if it still contains any XssMatchTuple objects.
    ///
    /// If you just want to remove an `XssMatchSet` from a `Rule`, use UpdateRule.
    ///
    /// To permanently delete an `XssMatchSet` from AWS WAF, perform the following
    /// steps:
    ///
    /// * Update the `XssMatchSet` to remove filters, if any. For more information,
    ///   see
    /// UpdateXssMatchSet.
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of a
    /// `DeleteXssMatchSet` request.
    ///
    /// * Submit a `DeleteXssMatchSet` request.
    pub fn deleteXssMatchSet(self: *Self, allocator: std.mem.Allocator, input: delete_xss_match_set.DeleteXssMatchSetInput, options: delete_xss_match_set.Options) !delete_xss_match_set.DeleteXssMatchSetOutput {
        return delete_xss_match_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns the ByteMatchSet specified by `ByteMatchSetId`.
    pub fn getByteMatchSet(self: *Self, allocator: std.mem.Allocator, input: get_byte_match_set.GetByteMatchSetInput, options: get_byte_match_set.Options) !get_byte_match_set.GetByteMatchSetOutput {
        return get_byte_match_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// When you want to create, update, or delete AWS WAF objects, get a change
    /// token and include the change token in the create, update, or delete request.
    /// Change tokens ensure that your application doesn't submit conflicting
    /// requests to AWS WAF.
    ///
    /// Each create, update, or delete request must use a unique change token. If
    /// your application submits a `GetChangeToken` request
    /// and then submits a second `GetChangeToken` request before submitting a
    /// create, update, or delete request, the second
    /// `GetChangeToken` request returns the same value as the first
    /// `GetChangeToken` request.
    ///
    /// When you use a change token in a create, update, or delete request, the
    /// status of the change token changes to `PENDING`,
    /// which indicates that AWS WAF is propagating the change to all AWS WAF
    /// servers. Use `GetChangeTokenStatus` to determine the
    /// status of your change token.
    pub fn getChangeToken(self: *Self, allocator: std.mem.Allocator, input: get_change_token.GetChangeTokenInput, options: get_change_token.Options) !get_change_token.GetChangeTokenOutput {
        return get_change_token.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns the status of a `ChangeToken` that you got by calling
    /// GetChangeToken. `ChangeTokenStatus` is
    /// one of the following values:
    ///
    /// * `PROVISIONED`: You requested the change token by calling `GetChangeToken`,
    ///   but you haven't used it yet
    /// in a call to create, update, or delete an AWS WAF object.
    ///
    /// * `PENDING`: AWS WAF is propagating the create, update, or delete request to
    ///   all AWS WAF servers.
    ///
    /// * `INSYNC`: Propagation is complete.
    pub fn getChangeTokenStatus(self: *Self, allocator: std.mem.Allocator, input: get_change_token_status.GetChangeTokenStatusInput, options: get_change_token_status.Options) !get_change_token_status.GetChangeTokenStatusOutput {
        return get_change_token_status.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns the GeoMatchSet that is specified by `GeoMatchSetId`.
    pub fn getGeoMatchSet(self: *Self, allocator: std.mem.Allocator, input: get_geo_match_set.GetGeoMatchSetInput, options: get_geo_match_set.Options) !get_geo_match_set.GetGeoMatchSetOutput {
        return get_geo_match_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns the IPSet that is specified by `IPSetId`.
    pub fn getIpSet(self: *Self, allocator: std.mem.Allocator, input: get_ip_set.GetIPSetInput, options: get_ip_set.Options) !get_ip_set.GetIPSetOutput {
        return get_ip_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns the LoggingConfiguration for the specified web ACL.
    pub fn getLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_logging_configuration.GetLoggingConfigurationInput, options: get_logging_configuration.Options) !get_logging_configuration.GetLoggingConfigurationOutput {
        return get_logging_configuration.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns the IAM policy attached to the RuleGroup.
    pub fn getPermissionPolicy(self: *Self, allocator: std.mem.Allocator, input: get_permission_policy.GetPermissionPolicyInput, options: get_permission_policy.Options) !get_permission_policy.GetPermissionPolicyOutput {
        return get_permission_policy.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns the RateBasedRule that is specified by the
    /// `RuleId` that you included in the `GetRateBasedRule`
    /// request.
    pub fn getRateBasedRule(self: *Self, allocator: std.mem.Allocator, input: get_rate_based_rule.GetRateBasedRuleInput, options: get_rate_based_rule.Options) !get_rate_based_rule.GetRateBasedRuleOutput {
        return get_rate_based_rule.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns an array of IP addresses currently being blocked by the
    /// RateBasedRule that is specified by the `RuleId`. The maximum
    /// number of managed keys that will be blocked is 10,000. If more than 10,000
    /// addresses exceed
    /// the rate limit, the 10,000 addresses with the highest rates will be blocked.
    pub fn getRateBasedRuleManagedKeys(self: *Self, allocator: std.mem.Allocator, input: get_rate_based_rule_managed_keys.GetRateBasedRuleManagedKeysInput, options: get_rate_based_rule_managed_keys.Options) !get_rate_based_rule_managed_keys.GetRateBasedRuleManagedKeysOutput {
        return get_rate_based_rule_managed_keys.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns the RegexMatchSet specified by `RegexMatchSetId`.
    pub fn getRegexMatchSet(self: *Self, allocator: std.mem.Allocator, input: get_regex_match_set.GetRegexMatchSetInput, options: get_regex_match_set.Options) !get_regex_match_set.GetRegexMatchSetOutput {
        return get_regex_match_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns the RegexPatternSet specified by `RegexPatternSetId`.
    pub fn getRegexPatternSet(self: *Self, allocator: std.mem.Allocator, input: get_regex_pattern_set.GetRegexPatternSetInput, options: get_regex_pattern_set.Options) !get_regex_pattern_set.GetRegexPatternSetOutput {
        return get_regex_pattern_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns the Rule that is specified by the `RuleId` that you included in the
    /// `GetRule` request.
    pub fn getRule(self: *Self, allocator: std.mem.Allocator, input: get_rule.GetRuleInput, options: get_rule.Options) !get_rule.GetRuleOutput {
        return get_rule.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns the RuleGroup that is specified by the `RuleGroupId` that you
    /// included in the `GetRuleGroup` request.
    ///
    /// To view the rules in a rule group, use ListActivatedRulesInRuleGroup.
    pub fn getRuleGroup(self: *Self, allocator: std.mem.Allocator, input: get_rule_group.GetRuleGroupInput, options: get_rule_group.Options) !get_rule_group.GetRuleGroupOutput {
        return get_rule_group.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Gets detailed information about a specified number of requests--a
    /// sample--that AWS WAF randomly selects from among the first 5,000 requests
    /// that your AWS resource received during a time range that you choose. You can
    /// specify a sample size of up to 500 requests, and you can specify any time
    /// range in the previous three hours.
    ///
    /// `GetSampledRequests` returns a time range, which is usually the time range
    /// that you specified. However, if your resource
    /// (such as a CloudFront distribution) received 5,000 requests before the
    /// specified time range elapsed, `GetSampledRequests`
    /// returns an updated time range. This new time range indicates the actual
    /// period during which AWS WAF selected the requests in the sample.
    pub fn getSampledRequests(self: *Self, allocator: std.mem.Allocator, input: get_sampled_requests.GetSampledRequestsInput, options: get_sampled_requests.Options) !get_sampled_requests.GetSampledRequestsOutput {
        return get_sampled_requests.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns the SizeConstraintSet specified by `SizeConstraintSetId`.
    pub fn getSizeConstraintSet(self: *Self, allocator: std.mem.Allocator, input: get_size_constraint_set.GetSizeConstraintSetInput, options: get_size_constraint_set.Options) !get_size_constraint_set.GetSizeConstraintSetOutput {
        return get_size_constraint_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns the SqlInjectionMatchSet that is specified by
    /// `SqlInjectionMatchSetId`.
    pub fn getSqlInjectionMatchSet(self: *Self, allocator: std.mem.Allocator, input: get_sql_injection_match_set.GetSqlInjectionMatchSetInput, options: get_sql_injection_match_set.Options) !get_sql_injection_match_set.GetSqlInjectionMatchSetOutput {
        return get_sql_injection_match_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns the WebACL that is specified by `WebACLId`.
    pub fn getWebAcl(self: *Self, allocator: std.mem.Allocator, input: get_web_acl.GetWebACLInput, options: get_web_acl.Options) !get_web_acl.GetWebACLOutput {
        return get_web_acl.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns the XssMatchSet that is specified by `XssMatchSetId`.
    pub fn getXssMatchSet(self: *Self, allocator: std.mem.Allocator, input: get_xss_match_set.GetXssMatchSetInput, options: get_xss_match_set.Options) !get_xss_match_set.GetXssMatchSetOutput {
        return get_xss_match_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns an array of ActivatedRule objects.
    pub fn listActivatedRulesInRuleGroup(self: *Self, allocator: std.mem.Allocator, input: list_activated_rules_in_rule_group.ListActivatedRulesInRuleGroupInput, options: list_activated_rules_in_rule_group.Options) !list_activated_rules_in_rule_group.ListActivatedRulesInRuleGroupOutput {
        return list_activated_rules_in_rule_group.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns an array of ByteMatchSetSummary objects.
    pub fn listByteMatchSets(self: *Self, allocator: std.mem.Allocator, input: list_byte_match_sets.ListByteMatchSetsInput, options: list_byte_match_sets.Options) !list_byte_match_sets.ListByteMatchSetsOutput {
        return list_byte_match_sets.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns an array of GeoMatchSetSummary objects in the response.
    pub fn listGeoMatchSets(self: *Self, allocator: std.mem.Allocator, input: list_geo_match_sets.ListGeoMatchSetsInput, options: list_geo_match_sets.Options) !list_geo_match_sets.ListGeoMatchSetsOutput {
        return list_geo_match_sets.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns an array of IPSetSummary objects in the response.
    pub fn listIpSets(self: *Self, allocator: std.mem.Allocator, input: list_ip_sets.ListIPSetsInput, options: list_ip_sets.Options) !list_ip_sets.ListIPSetsOutput {
        return list_ip_sets.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns an array of LoggingConfiguration objects.
    pub fn listLoggingConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_logging_configurations.ListLoggingConfigurationsInput, options: list_logging_configurations.Options) !list_logging_configurations.ListLoggingConfigurationsOutput {
        return list_logging_configurations.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns an array of RuleSummary objects.
    pub fn listRateBasedRules(self: *Self, allocator: std.mem.Allocator, input: list_rate_based_rules.ListRateBasedRulesInput, options: list_rate_based_rules.Options) !list_rate_based_rules.ListRateBasedRulesOutput {
        return list_rate_based_rules.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns an array of RegexMatchSetSummary objects.
    pub fn listRegexMatchSets(self: *Self, allocator: std.mem.Allocator, input: list_regex_match_sets.ListRegexMatchSetsInput, options: list_regex_match_sets.Options) !list_regex_match_sets.ListRegexMatchSetsOutput {
        return list_regex_match_sets.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns an array of RegexPatternSetSummary objects.
    pub fn listRegexPatternSets(self: *Self, allocator: std.mem.Allocator, input: list_regex_pattern_sets.ListRegexPatternSetsInput, options: list_regex_pattern_sets.Options) !list_regex_pattern_sets.ListRegexPatternSetsOutput {
        return list_regex_pattern_sets.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns an array of RuleGroup objects.
    pub fn listRuleGroups(self: *Self, allocator: std.mem.Allocator, input: list_rule_groups.ListRuleGroupsInput, options: list_rule_groups.Options) !list_rule_groups.ListRuleGroupsOutput {
        return list_rule_groups.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns an array of RuleSummary objects.
    pub fn listRules(self: *Self, allocator: std.mem.Allocator, input: list_rules.ListRulesInput, options: list_rules.Options) !list_rules.ListRulesOutput {
        return list_rules.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns an array of SizeConstraintSetSummary objects.
    pub fn listSizeConstraintSets(self: *Self, allocator: std.mem.Allocator, input: list_size_constraint_sets.ListSizeConstraintSetsInput, options: list_size_constraint_sets.Options) !list_size_constraint_sets.ListSizeConstraintSetsOutput {
        return list_size_constraint_sets.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns an array of SqlInjectionMatchSet objects.
    pub fn listSqlInjectionMatchSets(self: *Self, allocator: std.mem.Allocator, input: list_sql_injection_match_sets.ListSqlInjectionMatchSetsInput, options: list_sql_injection_match_sets.Options) !list_sql_injection_match_sets.ListSqlInjectionMatchSetsOutput {
        return list_sql_injection_match_sets.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns an array of RuleGroup objects that you are subscribed to.
    pub fn listSubscribedRuleGroups(self: *Self, allocator: std.mem.Allocator, input: list_subscribed_rule_groups.ListSubscribedRuleGroupsInput, options: list_subscribed_rule_groups.Options) !list_subscribed_rule_groups.ListSubscribedRuleGroupsOutput {
        return list_subscribed_rule_groups.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Retrieves the tags associated with the specified AWS resource. Tags are
    /// key:value pairs that you can use to categorize and manage your resources,
    /// for purposes like billing. For example, you might set the tag key to
    /// "customer" and the value to the customer name or ID. You can specify one or
    /// more tags to add to each AWS resource, up to 50 tags for a resource.
    ///
    /// Tagging is only available through the API, SDKs, and CLI. You can't manage
    /// or view tags through the AWS WAF Classic console. You can tag the AWS
    /// resources that you manage through AWS WAF Classic: web ACLs, rule groups,
    /// and rules.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns an array of WebACLSummary objects in the response.
    pub fn listWebAcLs(self: *Self, allocator: std.mem.Allocator, input: list_web_ac_ls.ListWebACLsInput, options: list_web_ac_ls.Options) !list_web_ac_ls.ListWebACLsOutput {
        return list_web_ac_ls.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Returns an array of XssMatchSet objects.
    pub fn listXssMatchSets(self: *Self, allocator: std.mem.Allocator, input: list_xss_match_sets.ListXssMatchSetsInput, options: list_xss_match_sets.Options) !list_xss_match_sets.ListXssMatchSetsOutput {
        return list_xss_match_sets.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Associates a LoggingConfiguration with a specified web ACL.
    ///
    /// You can access information about all traffic that AWS WAF inspects using the
    /// following
    /// steps:
    ///
    /// * Create an Amazon Kinesis Data
    /// Firehose.
    ///
    /// Create the data firehose with a PUT source and in the region that you are
    /// operating. However, if you are capturing logs for Amazon CloudFront, always
    /// create the firehose in US East (N. Virginia).
    ///
    /// Do not create the data firehose using a `Kinesis stream` as your source.
    ///
    /// * Associate that firehose to your web ACL using a `PutLoggingConfiguration`
    ///   request.
    ///
    /// When you successfully enable logging using a `PutLoggingConfiguration`
    /// request, AWS WAF will create a service linked role with the necessary
    /// permissions to write logs to the Amazon Kinesis Data Firehose. For more
    /// information, see [Logging Web ACL Traffic
    /// Information](https://docs.aws.amazon.com/waf/latest/developerguide/logging.html) in the *AWS WAF Developer Guide*.
    pub fn putLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_logging_configuration.PutLoggingConfigurationInput, options: put_logging_configuration.Options) !put_logging_configuration.PutLoggingConfigurationOutput {
        return put_logging_configuration.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Attaches an IAM policy to the specified resource. The only supported use for
    /// this action is to share a RuleGroup across accounts.
    ///
    /// The `PutPermissionPolicy` is subject to the following restrictions:
    ///
    /// * You can attach only one policy with each `PutPermissionPolicy` request.
    ///
    /// * The policy must include an `Effect`, `Action` and `Principal`.
    ///
    /// * `Effect` must specify `Allow`.
    ///
    /// * The `Action` in the policy must be `waf:UpdateWebACL`,
    ///   `waf-regional:UpdateWebACL`, `waf:GetRuleGroup` and
    ///   `waf-regional:GetRuleGroup` . Any extra or wildcard actions in the policy
    ///   will be rejected.
    ///
    /// * The policy cannot include a `Resource` parameter.
    ///
    /// * The ARN in the request must be a valid WAF RuleGroup ARN and the RuleGroup
    ///   must exist in the same region.
    ///
    /// * The user making the request must be the owner of the RuleGroup.
    ///
    /// * Your policy must be composed using IAM Policy version 2012-10-17.
    ///
    /// For more information, see [IAM
    /// Policies](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html).
    ///
    /// An example of a valid policy parameter is shown in the Examples section
    /// below.
    pub fn putPermissionPolicy(self: *Self, allocator: std.mem.Allocator, input: put_permission_policy.PutPermissionPolicyInput, options: put_permission_policy.Options) !put_permission_policy.PutPermissionPolicyOutput {
        return put_permission_policy.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Associates tags with the specified AWS resource. Tags are key:value pairs
    /// that you can use to categorize and manage your resources, for purposes like
    /// billing. For example, you might set the tag key to "customer" and the value
    /// to the customer name or ID. You can specify one or more tags to add to each
    /// AWS resource, up to 50 tags for a resource.
    ///
    /// Tagging is only available through the API, SDKs, and CLI. You can't manage
    /// or view tags through the AWS WAF Classic console. You can use this action to
    /// tag the AWS resources that you manage through AWS WAF Classic: web ACLs,
    /// rule groups, and rules.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Inserts or deletes ByteMatchTuple objects (filters) in a ByteMatchSet. For
    /// each `ByteMatchTuple` object,
    /// you specify the following values:
    ///
    /// * Whether to insert or delete the object from the array. If you want to
    ///   change a `ByteMatchSetUpdate` object,
    /// you delete the existing object and add a new one.
    ///
    /// * The part of a web request that you want AWS WAF to inspect, such as a
    ///   query string or the value of the `User-Agent` header.
    ///
    /// * The bytes (typically a string that corresponds with ASCII characters) that
    ///   you want AWS WAF to look for. For more information, including how you
    ///   specify
    /// the values for the AWS WAF API and the AWS CLI or SDKs, see `TargetString`
    /// in the ByteMatchTuple data type.
    ///
    /// * Where to look, such as at the beginning or the end of a query string.
    ///
    /// * Whether to perform any conversions on the request, such as converting it
    ///   to lowercase, before inspecting it for the specified string.
    ///
    /// For example, you can add a `ByteMatchSetUpdate` object that matches web
    /// requests in which `User-Agent` headers contain
    /// the string `BadBot`. You can then configure AWS WAF to block those requests.
    ///
    /// To create and configure a `ByteMatchSet`, perform the following steps:
    ///
    /// * Create a `ByteMatchSet.` For more information, see CreateByteMatchSet.
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// `UpdateByteMatchSet` request.
    ///
    /// * Submit an `UpdateByteMatchSet` request to specify the part of the request
    ///   that you want AWS WAF to inspect
    /// (for example, the header or the URI) and the value that you want AWS WAF to
    /// watch for.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the
    /// [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn updateByteMatchSet(self: *Self, allocator: std.mem.Allocator, input: update_byte_match_set.UpdateByteMatchSetInput, options: update_byte_match_set.Options) !update_byte_match_set.UpdateByteMatchSetOutput {
        return update_byte_match_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Inserts or deletes GeoMatchConstraint objects in an `GeoMatchSet`. For each
    /// `GeoMatchConstraint` object,
    /// you specify the following values:
    ///
    /// * Whether to insert or delete the object from the array. If you want to
    ///   change an `GeoMatchConstraint` object, you delete the existing object and
    ///   add a new one.
    ///
    /// * The `Type`. The only valid value for `Type` is `Country`.
    ///
    /// * The `Value`, which is a two character code for the country to add to the
    ///   `GeoMatchConstraint` object. Valid codes are listed in
    ///   GeoMatchConstraint$Value.
    ///
    /// To create and configure an `GeoMatchSet`, perform the following steps:
    ///
    /// * Submit a CreateGeoMatchSet request.
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// UpdateGeoMatchSet request.
    ///
    /// * Submit an `UpdateGeoMatchSet` request to specify the country that you want
    ///   AWS WAF to watch for.
    ///
    /// When you update an `GeoMatchSet`, you specify the country that you want to
    /// add and/or the country that you want to delete.
    /// If you want to change a country, you delete the existing country and add the
    /// new one.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the
    /// [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn updateGeoMatchSet(self: *Self, allocator: std.mem.Allocator, input: update_geo_match_set.UpdateGeoMatchSetInput, options: update_geo_match_set.Options) !update_geo_match_set.UpdateGeoMatchSetOutput {
        return update_geo_match_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Inserts or deletes IPSetDescriptor objects in an
    /// `IPSet`. For each `IPSetDescriptor` object, you specify the following
    /// values:
    ///
    /// * Whether to insert or delete the object from the array. If you want to
    ///   change an
    /// `IPSetDescriptor` object, you delete the existing object and add a new
    /// one.
    ///
    /// * The IP address version, `IPv4` or `IPv6`.
    ///
    /// * The IP address in CIDR notation, for example, `192.0.2.0/24` (for
    /// the range of IP addresses from `192.0.2.0` to `192.0.2.255`) or
    /// `192.0.2.44/32` (for the individual IP address
    /// `192.0.2.44`).
    ///
    /// AWS WAF supports IPv4 address ranges: /8 and any range between /16 through
    /// /32. AWS
    /// WAF supports IPv6 address ranges: /24, /32, /48, /56, /64, and /128. For
    /// more
    /// information about CIDR notation, see the Wikipedia entry [Classless
    /// Inter-Domain
    /// Routing](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing).
    ///
    /// IPv6 addresses can be represented using any of the following formats:
    ///
    /// * 1111:0000:0000:0000:0000:0000:0000:0111/128
    ///
    /// * 1111:0:0:0:0:0:0:0111/128
    ///
    /// * 1111::0111/128
    ///
    /// * 1111::111/128
    ///
    /// You use an `IPSet` to specify which web requests you want to allow or
    /// block based on the IP addresses that the requests originated from. For
    /// example, if you're
    /// receiving a lot of requests from one or a small number of IP addresses and
    /// you want to
    /// block the requests, you can create an `IPSet` that specifies those IP
    /// addresses,
    /// and then configure AWS WAF to block the requests.
    ///
    /// To create and configure an `IPSet`, perform the following steps:
    ///
    /// * Submit a CreateIPSet request.
    ///
    /// * Use GetChangeToken to get the change token that you provide
    /// in the `ChangeToken` parameter of an UpdateIPSet
    /// request.
    ///
    /// * Submit an `UpdateIPSet` request to specify the IP addresses that you
    /// want AWS WAF to watch for.
    ///
    /// When you update an `IPSet`, you specify the IP addresses that you want to
    /// add and/or the IP addresses that you want to delete. If you want to change
    /// an IP address,
    /// you delete the existing IP address and add the new one.
    ///
    /// You can insert a maximum of 1000 addresses in a single
    /// request.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the [AWS WAF
    /// Developer Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn updateIpSet(self: *Self, allocator: std.mem.Allocator, input: update_ip_set.UpdateIPSetInput, options: update_ip_set.Options) !update_ip_set.UpdateIPSetOutput {
        return update_ip_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Inserts or deletes Predicate objects in a rule and updates the
    /// `RateLimit` in the rule.
    ///
    /// Each `Predicate` object identifies a predicate, such as a ByteMatchSet or an
    /// IPSet, that specifies the web requests
    /// that you want to block or count. The `RateLimit` specifies the number of
    /// requests every five minutes that triggers the rule.
    ///
    /// If you add more than one predicate to a `RateBasedRule`, a request must
    /// match all the predicates and exceed the `RateLimit` to be counted or
    /// blocked.
    /// For example, suppose you add the following to a `RateBasedRule`:
    ///
    /// * An `IPSet` that matches the IP address `192.0.2.44/32`
    ///
    /// * A `ByteMatchSet` that matches `BadBot` in the
    /// `User-Agent` header
    ///
    /// Further, you specify a
    /// `RateLimit` of 1,000.
    ///
    /// You then add the `RateBasedRule` to a `WebACL` and specify that
    /// you want to block requests that satisfy the rule. For a request to be
    /// blocked, it must come
    /// from the IP address 192.0.2.44 *and* the `User-Agent` header
    /// in the request must contain the value `BadBot`. Further, requests that match
    /// these two conditions much be received at a rate of more than 1,000 every
    /// five minutes. If
    /// the rate drops below this limit, AWS WAF no longer blocks the requests.
    ///
    /// As a second example, suppose you want to limit requests to a particular page
    /// on your site. To do this, you could add the following to a
    /// `RateBasedRule`:
    ///
    /// * A `ByteMatchSet` with `FieldToMatch` of `URI`
    ///
    /// * A `PositionalConstraint` of `STARTS_WITH`
    ///
    /// * A `TargetString` of `login`
    ///
    /// Further, you specify a `RateLimit` of 1,000.
    ///
    /// By adding this `RateBasedRule` to a `WebACL`, you could limit requests to
    /// your login page without affecting the rest of your site.
    pub fn updateRateBasedRule(self: *Self, allocator: std.mem.Allocator, input: update_rate_based_rule.UpdateRateBasedRuleInput, options: update_rate_based_rule.Options) !update_rate_based_rule.UpdateRateBasedRuleOutput {
        return update_rate_based_rule.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Inserts or deletes RegexMatchTuple objects (filters) in a RegexMatchSet. For
    /// each `RegexMatchSetUpdate` object,
    /// you specify the following values:
    ///
    /// * Whether to insert or delete the object from the array. If you want to
    ///   change a `RegexMatchSetUpdate` object,
    /// you delete the existing object and add a new one.
    ///
    /// * The part of a web request that you want AWS WAF to inspectupdate, such as
    ///   a query string or the value of the `User-Agent` header.
    ///
    /// * The identifier of the pattern (a regular expression) that you want AWS WAF
    ///   to look for. For more information, see RegexPatternSet.
    ///
    /// * Whether to perform any conversions on the request, such as converting it
    ///   to lowercase, before inspecting it for the specified string.
    ///
    /// For example, you can create a `RegexPatternSet` that matches any requests
    /// with `User-Agent` headers
    /// that contain the string `B[a@]dB[o0]t`. You can then configure AWS WAF to
    /// reject those requests.
    ///
    /// To create and configure a `RegexMatchSet`, perform the following steps:
    ///
    /// * Create a `RegexMatchSet.` For more information, see CreateRegexMatchSet.
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// `UpdateRegexMatchSet` request.
    ///
    /// * Submit an `UpdateRegexMatchSet` request to specify the part of the request
    ///   that you want AWS WAF to inspect
    /// (for example, the header or the URI) and the identifier of the
    /// `RegexPatternSet` that contain the regular expression patters you want AWS
    /// WAF to watch for.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the
    /// [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn updateRegexMatchSet(self: *Self, allocator: std.mem.Allocator, input: update_regex_match_set.UpdateRegexMatchSetInput, options: update_regex_match_set.Options) !update_regex_match_set.UpdateRegexMatchSetOutput {
        return update_regex_match_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Inserts or deletes `RegexPatternString` objects in a RegexPatternSet. For
    /// each `RegexPatternString` object,
    /// you specify the following values:
    ///
    /// * Whether to insert or delete the `RegexPatternString`.
    ///
    /// * The regular expression pattern that you want to insert or delete. For more
    ///   information, see RegexPatternSet.
    ///
    /// For example, you can create a `RegexPatternString` such as `B[a@]dB[o0]t`.
    /// AWS WAF will match this `RegexPatternString` to:
    ///
    /// * BadBot
    ///
    /// * BadB0t
    ///
    /// * B@dBot
    ///
    /// * B@dB0t
    ///
    /// To create and configure a `RegexPatternSet`, perform the following steps:
    ///
    /// * Create a `RegexPatternSet.` For more information, see
    ///   CreateRegexPatternSet.
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// `UpdateRegexPatternSet` request.
    ///
    /// * Submit an `UpdateRegexPatternSet` request to specify the regular
    ///   expression pattern that you want AWS WAF to watch for.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the
    /// [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn updateRegexPatternSet(self: *Self, allocator: std.mem.Allocator, input: update_regex_pattern_set.UpdateRegexPatternSetInput, options: update_regex_pattern_set.Options) !update_regex_pattern_set.UpdateRegexPatternSetOutput {
        return update_regex_pattern_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Inserts or deletes Predicate objects in a `Rule`. Each
    /// `Predicate` object identifies a predicate, such as a ByteMatchSet or an
    /// IPSet, that specifies the web requests
    /// that you want to allow, block, or count. If you add more than one predicate
    /// to a
    /// `Rule`, a request must match all of the specifications to be allowed,
    /// blocked, or counted. For example, suppose
    /// that
    /// you add the following to a `Rule`:
    ///
    /// * A `ByteMatchSet` that matches the value `BadBot` in the `User-Agent`
    ///   header
    ///
    /// * An `IPSet` that matches the IP address `192.0.2.44`
    ///
    /// You then add the `Rule` to a `WebACL` and specify that you want to block
    /// requests that satisfy the `Rule`.
    /// For a request to be blocked, the `User-Agent` header in the request must
    /// contain the value `BadBot`
    /// *and* the request must originate from the IP address 192.0.2.44.
    ///
    /// To create and configure a `Rule`, perform the following steps:
    ///
    /// * Create and update the predicates that you want to include in the `Rule`.
    ///
    /// * Create the `Rule`. See CreateRule.
    ///
    /// * Use `GetChangeToken` to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// UpdateRule request.
    ///
    /// * Submit an `UpdateRule` request to add predicates to the `Rule`.
    ///
    /// * Create and update a `WebACL` that contains the `Rule`. See CreateWebACL.
    ///
    /// If you want to replace one `ByteMatchSet` or `IPSet` with another, you
    /// delete the existing one and
    /// add the new one.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the
    /// [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn updateRule(self: *Self, allocator: std.mem.Allocator, input: update_rule.UpdateRuleInput, options: update_rule.Options) !update_rule.UpdateRuleOutput {
        return update_rule.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Inserts or deletes ActivatedRule objects in a `RuleGroup`.
    ///
    /// You can only insert `REGULAR` rules into a rule group.
    ///
    /// You can have a maximum of ten rules per rule group.
    ///
    /// To create and configure a `RuleGroup`, perform the following steps:
    ///
    /// * Create and update the `Rules` that you want to include in the `RuleGroup`.
    ///   See CreateRule.
    ///
    /// * Use `GetChangeToken` to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// UpdateRuleGroup request.
    ///
    /// * Submit an `UpdateRuleGroup` request to add `Rules` to the `RuleGroup`.
    ///
    /// * Create and update a `WebACL` that contains the `RuleGroup`. See
    ///   CreateWebACL.
    ///
    /// If you want to replace one `Rule` with another, you delete the existing one
    /// and
    /// add the new one.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the
    /// [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn updateRuleGroup(self: *Self, allocator: std.mem.Allocator, input: update_rule_group.UpdateRuleGroupInput, options: update_rule_group.Options) !update_rule_group.UpdateRuleGroupOutput {
        return update_rule_group.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Inserts or deletes SizeConstraint objects (filters) in a SizeConstraintSet.
    /// For each `SizeConstraint` object,
    /// you specify the following values:
    ///
    /// * Whether to insert or delete the object from the array. If you want to
    ///   change a `SizeConstraintSetUpdate` object,
    /// you delete the existing object and add a new one.
    ///
    /// * The part of a web request that you want AWS WAF to evaluate, such as the
    ///   length of a query string or the length of the
    /// `User-Agent` header.
    ///
    /// * Whether to perform any transformations on the request, such as converting
    ///   it to lowercase, before checking its length.
    /// Note that transformations of the request body are not supported because the
    /// AWS resource forwards only the first `8192` bytes
    /// of your request to AWS WAF.
    ///
    /// You can only specify a single type of TextTransformation.
    ///
    /// * A `ComparisonOperator` used for evaluating the selected part of the
    ///   request against the specified `Size`, such as
    /// equals, greater than, less than, and so on.
    ///
    /// * The length, in bytes, that you want AWS WAF to watch for in selected part
    ///   of the request. The length is computed after applying the transformation.
    ///
    /// For example, you can add a `SizeConstraintSetUpdate` object that matches web
    /// requests in which the length of the
    /// `User-Agent` header is greater than 100 bytes. You can then configure AWS
    /// WAF to block those requests.
    ///
    /// To create and configure a `SizeConstraintSet`, perform the following steps:
    ///
    /// * Create a `SizeConstraintSet.` For more information, see
    ///   CreateSizeConstraintSet.
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// `UpdateSizeConstraintSet` request.
    ///
    /// * Submit an `UpdateSizeConstraintSet` request to specify the part of the
    ///   request that you want AWS WAF to inspect
    /// (for example, the header or the URI) and the value that you want AWS WAF to
    /// watch for.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the
    /// [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn updateSizeConstraintSet(self: *Self, allocator: std.mem.Allocator, input: update_size_constraint_set.UpdateSizeConstraintSetInput, options: update_size_constraint_set.Options) !update_size_constraint_set.UpdateSizeConstraintSetOutput {
        return update_size_constraint_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Inserts or deletes SqlInjectionMatchTuple objects (filters) in a
    /// SqlInjectionMatchSet.
    /// For each `SqlInjectionMatchTuple` object, you specify the following values:
    ///
    /// * `Action`: Whether to insert the object into or delete the object from the
    ///   array. To change a
    /// `SqlInjectionMatchTuple`, you delete the existing object and add a new one.
    ///
    /// * `FieldToMatch`: The part of web requests that you want AWS WAF to inspect
    ///   and, if you want AWS WAF to inspect a header or custom query parameter,
    /// the name of the header or parameter.
    ///
    /// * `TextTransformation`: Which text transformation, if any, to perform on the
    ///   web request before
    /// inspecting the request for snippets of malicious SQL code.
    ///
    /// You can only specify a single type of TextTransformation.
    ///
    /// You use `SqlInjectionMatchSet` objects to specify which CloudFront
    /// requests that
    /// you want to allow, block, or count. For example, if you're receiving
    /// requests that contain snippets of SQL code in the query string and you want
    /// to block the
    /// requests, you can create a `SqlInjectionMatchSet` with the applicable
    /// settings,
    /// and then configure AWS WAF to block the requests.
    ///
    /// To create and configure a `SqlInjectionMatchSet`, perform the following
    /// steps:
    ///
    /// * Submit a CreateSqlInjectionMatchSet request.
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// UpdateIPSet request.
    ///
    /// * Submit an `UpdateSqlInjectionMatchSet` request to specify the parts of web
    ///   requests that you want AWS WAF to
    /// inspect for snippets of SQL code.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the
    /// [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn updateSqlInjectionMatchSet(self: *Self, allocator: std.mem.Allocator, input: update_sql_injection_match_set.UpdateSqlInjectionMatchSetInput, options: update_sql_injection_match_set.Options) !update_sql_injection_match_set.UpdateSqlInjectionMatchSetOutput {
        return update_sql_injection_match_set.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Inserts or deletes ActivatedRule objects in a `WebACL`. Each `Rule`
    /// identifies
    /// web requests that you want to allow, block, or count. When you update a
    /// `WebACL`, you specify the following values:
    ///
    /// * A default action for the `WebACL`, either `ALLOW` or `BLOCK`.
    /// AWS WAF performs the default action if a request doesn't match the criteria
    /// in any of the `Rules` in a `WebACL`.
    ///
    /// * The `Rules` that you want to add
    /// or
    /// delete. If you want to replace one `Rule` with another, you delete the
    /// existing `Rule` and add the new one.
    ///
    /// * For each `Rule`, whether you want AWS WAF to allow requests, block
    ///   requests, or count requests that match
    /// the conditions in the `Rule`.
    ///
    /// * The order in which you want AWS WAF to evaluate the `Rules` in a
    /// `WebACL`. If you add more than one `Rule` to a
    /// `WebACL`, AWS WAF evaluates each request against the `Rules`
    /// in order based on the value of `Priority`. (The `Rule` that has
    /// the lowest value for `Priority` is evaluated first.) When a web request
    /// matches all
    /// the
    /// predicates (such as `ByteMatchSets` and `IPSets`) in a
    /// `Rule`, AWS WAF immediately takes the corresponding action, allow or
    /// block, and doesn't evaluate the request against the remaining `Rules` in
    /// the `WebACL`, if any.
    ///
    /// To create and configure a `WebACL`, perform the following steps:
    ///
    /// * Create and update the predicates that you want to include in `Rules`.
    /// For more information, see CreateByteMatchSet, UpdateByteMatchSet,
    /// CreateIPSet, UpdateIPSet,
    /// CreateSqlInjectionMatchSet, and UpdateSqlInjectionMatchSet.
    ///
    /// * Create and update the `Rules` that you want to include in the `WebACL`.
    ///   For more information, see
    /// CreateRule and UpdateRule.
    ///
    /// * Create a `WebACL`. See CreateWebACL.
    ///
    /// * Use `GetChangeToken` to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// UpdateWebACL request.
    ///
    /// * Submit an `UpdateWebACL` request to specify the `Rules`
    /// that you want to include in the `WebACL`, to specify the default action,
    /// and to associate the `WebACL` with a CloudFront distribution.
    ///
    /// The `ActivatedRule` can be a rule group. If you specify a rule group
    /// as your
    /// `ActivatedRule`
    /// ,
    /// you can exclude specific rules from that rule group.
    ///
    /// If you already have a rule group associated with a web ACL and want to
    /// submit
    /// an `UpdateWebACL` request to exclude certain rules from that rule group,
    /// you must first remove the rule group from the web ACL, the re-insert it
    /// again,
    /// specifying the excluded rules.
    /// For details,
    /// see
    /// ActivatedRule$ExcludedRules
    /// .
    ///
    /// Be aware that if you try to add a RATE_BASED rule to a web ACL without
    /// setting the rule type when first creating the rule, the UpdateWebACL request
    /// will fail because the request tries to add a REGULAR rule (the default rule
    /// type) with the specified ID, which does not exist.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn updateWebAcl(self: *Self, allocator: std.mem.Allocator, input: update_web_acl.UpdateWebACLInput, options: update_web_acl.Options) !update_web_acl.UpdateWebACLOutput {
        return update_web_acl.execute(self, allocator, input, options);
    }

    /// This is **AWS WAF Classic** documentation. For
    /// more information, see [AWS
    /// WAF
    /// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
    ///
    /// **For the latest version of AWS
    /// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
    ///
    /// Inserts or deletes XssMatchTuple objects (filters) in an XssMatchSet.
    /// For each `XssMatchTuple` object, you specify the following values:
    ///
    /// * `Action`: Whether to insert the object into or delete the object from the
    /// array. To change an
    /// `XssMatchTuple`, you delete the existing object and add a new
    /// one.
    ///
    /// * `FieldToMatch`: The part of web requests that you want AWS WAF to inspect
    ///   and, if you want AWS WAF to inspect a header or custom query parameter,
    /// the name of the header or parameter.
    ///
    /// * `TextTransformation`: Which text transformation, if any, to perform on the
    ///   web request before
    /// inspecting the request for cross-site scripting attacks.
    ///
    /// You can only specify a single type of TextTransformation.
    ///
    /// You use `XssMatchSet` objects to specify which CloudFront requests
    /// that
    /// you want to allow, block, or count. For example, if you're receiving
    /// requests that contain cross-site scripting attacks in the request body and
    /// you want to
    /// block the requests, you can create an `XssMatchSet` with the applicable
    /// settings, and then configure AWS WAF to block the requests.
    ///
    /// To create and configure an `XssMatchSet`, perform the following steps:
    ///
    /// * Submit a CreateXssMatchSet request.
    ///
    /// * Use GetChangeToken to get the change token that you provide in the
    ///   `ChangeToken` parameter of an
    /// UpdateIPSet request.
    ///
    /// * Submit an `UpdateXssMatchSet` request to specify the parts of web requests
    ///   that you want AWS WAF to
    /// inspect for cross-site scripting attacks.
    ///
    /// For more information about how to use the AWS WAF API to allow or block HTTP
    /// requests, see the
    /// [AWS WAF Developer
    /// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/).
    pub fn updateXssMatchSet(self: *Self, allocator: std.mem.Allocator, input: update_xss_match_set.UpdateXssMatchSetInput, options: update_xss_match_set.Options) !update_xss_match_set.UpdateXssMatchSetOutput {
        return update_xss_match_set.execute(self, allocator, input, options);
    }
};
