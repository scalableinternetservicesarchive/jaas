module MatchesHelper
  def cache_key_for_match(match)
    "match-#{match.id}-#{match.updated_at}-#{match.created_at}"
  end
  def cache_key_for_match_not_found(match)
    "match_not_found-#{match.id}-#{match.updated_at}-#{match.created_at}"
  end
end
