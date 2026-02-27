/// Set of rule statements, used with FlexMatch, that determine how to build
/// your player
/// matches. Each rule set describes a type of group to be created and defines
/// the
/// parameters for acceptable player matches.
///
/// A rule set may define the following elements for a match. For detailed
/// information and
/// examples showing how to construct a rule set, see [Build a FlexMatch rule
/// set](https://docs.aws.amazon.com/gamelift/latest/flexmatchguide/match-rulesets.html).
///
/// * Teams -- Required. A rule set must define one or multiple teams for the
///   match
/// and set minimum and maximum team sizes. For example, a rule set might
/// describe a
/// 4x4 match that requires all eight slots to be filled.
///
/// * Player attributes -- Optional. These attributes specify a set of player
/// characteristics to evaluate when looking for a match. Matchmaking requests
/// that
/// use a rule set with player attributes must provide the corresponding
/// attribute
/// values. For example, an attribute might specify a player's skill or
/// level.
///
/// * Rules -- Optional. Rules define how to evaluate potential players for a
///   match
/// based on player attributes. A rule might specify minimum requirements for
/// individual players, teams, or entire matches. For example, a rule might
/// require
/// each player to meet a certain skill level, each team to have at least one
/// player
/// in a certain role, or the match to have a minimum average skill level. or
/// may
/// describe an entire group--such as all teams must be evenly matched or have
/// at
/// least one player in a certain role.
///
/// * Expansions -- Optional. Expansions allow you to relax the rules after a
///   period
/// of time when no acceptable matches are found. This feature lets you balance
/// getting players into games in a reasonable amount of time instead of making
/// them
/// wait indefinitely for the best possible match. For example, you might use an
/// expansion to increase the maximum skill variance between players after 30
/// seconds.
pub const MatchmakingRuleSet = struct {
    /// A time stamp indicating when this data object was created. Format is a
    /// number expressed in Unix time as milliseconds (for example
    /// `"1469498468.057"`).
    creation_time: ?i64,

    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to a Amazon GameLift Servers matchmaking rule set resource
    /// and uniquely identifies it. ARNs are unique across all Regions. Format is
    /// `arn:aws:gamelift:::matchmakingruleset/`. In a GameLift rule set ARN, the
    /// resource ID matches the
    /// *RuleSetName* value.
    rule_set_arn: ?[]const u8,

    /// A collection of matchmaking rules, formatted as a JSON string. Comments are
    /// not
    /// allowed in JSON, but most elements support a description field.
    rule_set_body: []const u8,

    /// A unique identifier for the matchmaking rule set
    rule_set_name: ?[]const u8,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .rule_set_arn = "RuleSetArn",
        .rule_set_body = "RuleSetBody",
        .rule_set_name = "RuleSetName",
    };
};
