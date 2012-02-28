class Region

  @@all_regions = %w{us-east-1 us-west-2 us-west-1 eu-west-1 ap-southeast-1 ap-northeast-1 sa-east-1}
  @@region = nil

  def self.region
    @@region == nil ? "eu-west-1" : @@region 
  end 
  def self.set_region(region)
    raise "Unrecognized region #{region} - should be one of #{@@all_regions.join(', ')}" unless @@all_regions.include?region
    @@region = region
  end
  
  def self.all_regions
    @@all_regions 
  end
end
