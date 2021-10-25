class Gossip
    attr_accessor :author, :content

    def initialize(content, author)
        @content = content
        @author = author
    end

    def save
        CSV.open('./db/gossip.csv', 'ab') do |csv|
            csv << [@content, @author]
        end
    end

    def self.save_comment(comment, id)
        CSV.open('./db/comment.csv', 'ab') do |csv|
            csv << [id, comment]
        end
    end

    def self.all
        all_gossips = []
        CSV.read('./db/gossip.csv').each do |csv_line|
            all_gossips << Gossip.new(csv_line[0], csv_line[1])
        end
        return all_gossips
    end

    def self.find(id)
        return Gossip.all[id]
    end

    def self.all_comments
        all_comments = []
        CSV.read('./db/comment.csv').each do |csv_line|
            all_comments << [csv_line[0], csv_line[1]]
        end
        return all_comments
    end
end