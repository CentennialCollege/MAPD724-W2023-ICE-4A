import SpriteKit
import GameplayKit

class CollisionManager
{
    public static var gameViewController: GameViewController?
    
    // Utility Functions
    
    public static func SquaredDistance(point1: CGPoint, point2: CGPoint) -> CGFloat
    {
        let Xs: CGFloat = point2.x - point1.x
        let Ys: CGFloat = point2.y - point1.y
        return Xs * Xs + Ys * Ys
    }
    
    // Collision Functions
    public static func SquaredRadiusCheck(scene: SKScene, object1: GameObject, object2: GameObject)
    {
        let P1 = object1.position
        let P2 = object2.position
        let P1Radius = object1.halfHeight!
        let P2Radius = object2.halfHeight!
        let Radii = P1Radius + P2Radius
        
        if(SquaredDistance(point1: P1, point2: P2) < Radii * Radii)
        {
            // we have a collision
            if(!object2.isColliding!)
            {
                // if object2 is not already colliding
                switch(object2.name)
                {
                case "island":
                    ScoreManager.Score += 100
                    gameViewController?.updateScoreLabel()
                    scene.run(SKAction.playSoundFileNamed("yay", waitForCompletion: false))
                    // give player extra life every 2000 points
                    if(ScoreManager.Score % 2000 == 0)
                    {
                        ScoreManager.Lives += 1
                        gameViewController?.updateLivesLabel()
                        // play some "Lives Added" Sound
                    }
                    break
                case "cloud":
                    ScoreManager.Lives -= 1
                    gameViewController?.updateLivesLabel()
                    scene.run(SKAction.playSoundFileNamed("thunder", waitForCompletion: false))
                    if(ScoreManager.Lives < 1)
                    {
                        gameViewController?.presentEndScene()
                    }
                    break
                default:
                    break
                }
                object2.isColliding = true
            }
        }
    }
}
